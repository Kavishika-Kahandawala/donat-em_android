import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/authenticate/reg_steppers/stepper_home.dart';
import 'package:donatem/screens/main/loyalty/loyalty.dart';
import 'package:donatem/screens/main/maps/here_json_format.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:donatem/shared/inputTextArea_1.dart';
import 'package:donatem/shared/inputTextArea_3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_bar_steppers/steppers.dart';

class RegStepLocation extends StatefulWidget {
  const RegStepLocation({super.key});

  @override
  State<RegStepLocation> createState() => _RegStepLocationState();
}

class _RegStepLocationState extends State<RegStepLocation> {
  //controllers
  final locationController = TextEditingController();

  // Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  // Push fname,lname to firestore
  Future addUserRegData() async {
    // show loading icon
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'user_lng': locationLng,
        'user_lat': locationLat,
        'user_location_name': locationController.text.trim(),
        'reg_step': 4,
      },
      SetOptions(merge: true),
    );
    //pop loading circle
    Navigator.pop(context);
    {
      Get.to(() => const StepperHome());
    }
  }

  final stepsData = [
    StepperData(
      label: 'Step 1',
    ),
    StepperData(
      label: 'Step 2',
    ),
    StepperData(
      label: 'Step 3',
    ),
    StepperData(
      label: 'Step 4',
    ),
  ];

  //progress bar stuff
  int currentStep = 4;
  int maxSteps = 4;

  //new code

  final StreamController<List<String>> _listStreamController =
      StreamController<List<String>>();

  double locationLng = 0.0;
  double locationLat = 0.0;

  // List<HereLoc> hereLocList = [];
  // List<HereLoc> items = [];
  List<String> cityNameList = [];
  List<double> lngList = [];
  List<double> latList = [];

  Future<List<String>> getData(String location) async {
    cityNameList.clear();
    lngList.clear();
    latList.clear();
    final response = await http.get(Uri.parse(
        'https://autosuggest.search.hereapi.com/v1/autosuggest?at=6.93194,79.84778&lang=en&q=$location&limit=4&apiKey=1AO6iReaNI4Mxj8I0RO-NMUniTyNhfQS3dKV9wQMjIM'));
    var data = jsonDecode(response.body);
    try {
      if (response.statusCode == 200) {
      HereLoc hereRestLocation = HereLoc.fromJson(data);
      for (Item item in hereRestLocation.items) {
        cityNameList.add(item.title);
        lngList.add(item.position.lng);
        latList.add(item.position.lat);
        insertListToStream(cityNameList);
      }
      return cityNameList;
    } else {
      return cityNameList;
    }
    } catch (e) {
      return cityNameList;
    }
  }

  void insertListToStream(List<String> dataList) {
    _listStreamController.add(dataList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LinearProgressBar(
              maxSteps: maxSteps,
              progressType: LinearProgressBar.progressTypeLinear,
              currentStep: currentStep,
              progressColor: Colors.deepPurple,
              backgroundColor: Colors.white,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.deepPurple.shade400),
              semanticsLabel: "Label",
              semanticsValue: "Value",
              // minHeight: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            Steppers(
              direction: StepperDirection.horizontal,
              labels: stepsData,
              currentStep: currentStep,
              stepBarStyle: StepperStyle(
                activeColor: Colors.deepPurple.shade400,
                maxLineLabel: 2,
                inactiveColor: Colors.deepPurple.shade100,
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  InputTextArea3(
                    controller: locationController,
                    hintText: 'Enter your city name',
                    obscureText: false,
                    onTap: (text) {
                      if (locationController.text.trim().isNotEmpty) {
                        Future.delayed(Duration.zero, () {
                          getData(text);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<String>>(
                stream: _listStreamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error loading data'),
                    );
                  }
                  if (!snapshot.hasData) {
                    debugPrint('no data');
                    return Lottie.asset(
                      'lib/assets/icons/location.json', // Path to your animation JSON file
                      height: 200,
                      width: 200,
                    );
                  }
                  final items = snapshot.data!;
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(height: 40,
                              //   child: Text(items[index])),
                              GestureDetector(
                                child: Text(items[index]),
                                onTap: () {
                                  locationLng = lngList[index];
                                  locationLat = latList[index];
                                  setState(() {
                                    locationController.text = items[index];
                                    insertListToStream([]);
                                  });
                                },
                              ),
                              Divider(color: Colors.grey.shade500)
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: InputButton1(
                  onTap: addUserRegData,
                  text: 'Submit'),
            ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.50),
          ],
        ),
      ),
    );
  }
}
