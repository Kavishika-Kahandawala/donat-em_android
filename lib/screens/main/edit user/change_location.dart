import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/maps/here_json_format.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:donatem/shared/inputTextArea_3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class ChangeUserLocation extends StatefulWidget {
  const ChangeUserLocation({super.key});

  @override
  State<ChangeUserLocation> createState() => _ChangeUserLocationState();
}

class _ChangeUserLocationState extends State<ChangeUserLocation> {
  //controllers
  final locationController = TextEditingController();

  // Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  // Push fname,lname to firestore
  Future addUserRegData() async {
    if (checker) {
      // show loading icon
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      await FirebaseFirestore.instance .collection('users')
        .doc(uid)
        .set(
        {
          'user_lng': locationLng,
          'user_lat': locationLat,
          'user_location_name': locationController.text.trim(),
        },
        SetOptions(merge: true),
      );
      //pop loading circle
      Navigator.pop(context);
      {
        Get.back();
      }
    } else {
      showErrorMsg('Error', 'Please select a location');
    }
  }


  @override
  void initState() {
    super.initState();
  }
 

  void showErrorMsg(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
              // 'It looks like ${emailController.text.trim()} isn\'t found in our database. Make sure correct E-mail has been entered'
              message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'))
          ],
        );
      },
    );
  }

  //new code

  final StreamController<List<String>> _listStreamController =
      StreamController<List<String>>();

  double locationLng = 0.0;
  double locationLat = 0.0;

  bool checker = false;

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
  void dispose() {
    _listStreamController.close();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple.shade300,
        elevation:0.0,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(
            //   height: 20,
            // ),
              // const SizedBox(height: 20),
            // const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [

                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Change Location',
                      style: GoogleFonts.poppins(
                        // fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InputTextArea3(
                    controller: locationController,
                    hintText: 'Enter your new location',
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
                      'lib/assets/icons/place.json', // Path to your animation JSON file
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
                                    checker = true;
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
              child: InputButton1(onTap: addUserRegData, text: 'Submit'),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.50),
          ],
        ),
      ),
    );
  }
}
