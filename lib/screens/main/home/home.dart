import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/home/happening%20now/home_display_all_events.dart';
import 'package:donatem/shared/home_streambuilder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart%20%20';

import '../../../shared/heading_see_all.dart';

class MainPageUI extends StatefulWidget {
  const MainPageUI({super.key});

  @override
  State<MainPageUI> createState() => _MainPageUIState();
}

class _MainPageUIState extends State<MainPageUI> {
  // Document IDs to parse
  List<String> eventDocIds = [];
  List<String> donateItemsDocIds = [];
  List<String> offerShopIds = [];

  // firestore strings
  String firstName = '';
  String greeting = '';

  // firebase uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  Future loadUserInfo() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((querySnapshot) {
      setState(() {
        firstName = querySnapshot.get('first_name');
      });
    });
  }

  Future loadEventsDetails() async {
    int docLimit = 5;
    await FirebaseFirestore.instance
        .collection('org events')
        .limit(docLimit)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        eventDocIds.add(result.id);
      }
      firstName = querySnapshot.docs[0].get('event_name');
      print(eventDocIds);
    });
  }

  void greetings() {
    final hour = TimeOfDay.now().hour;
    String output = 'Good Evening,';
    if (hour < 12) {
      output = 'Good Morning,';
    } else if (hour <= 17) {
      output = 'Good Afternoon,';
    }

    setState(() {
      greeting = output;
    });
  }

  //get  docIDs
  Future getEventDocIds() async {
    await FirebaseFirestore.instance
        .collection('org events')
        .where('status', isEqualTo: 1)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        eventDocIds.add(result.id);
      }
    });
  }

  // Future testHello() async {
  //   const String docId = "LHrm6sjFnU3xVt0U7T6h";
  //   CollectionReference events =
  //       FirebaseFirestore.instance.collection('users');
  //   return FutureBuilder<DocumentSnapshot>(
  //     future: events.doc(uid).get(),
  //     builder: (context, snapshot) {
  //       print('>>>>>>>> came here');
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         Map<String, dynamic> data =
  //             snapshot.data!.data() as Map<String, dynamic>;
  //         print(data['event_name']);
  //         // return Text("Event Name: ${data['event_name']}");
  //       }
  //       return const Text("loading");
  //     },
  //   );
  // }

  @override
  void initState() {
    // testHello();
    loadEventsDetails();
    greetings();
    getEventDocIds();
    loadUserInfo();
    super.initState();
  }

  void replaceVoid() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          greeting,
                          style: GoogleFonts.poppins(
                            // fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          firstName,
                          style: GoogleFonts.poppins(
                            // fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.person),
                    ),
                  ],
                ),
              ),
              // blank box to separate
              const SizedBox(height: 20),

              Expanded(
                child: ListTileTheme(
                  child: ListView(
                    children: [
                      //   ListView.builder(itemCount: 3,itemBuilder:(context, index) {

                      // },),
                      HeadingSeeAll(
                        heading: 'Fundraising events happening now',
                        onTap: () {
                          Get.to(() => const HomeDisplayAllEvents());
                        },
                      ),
                      const SizedBox(height: 10),
                      // check whether sized box or container TODO:
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      //   child: SizedBox(
                      //     height: 120,
                      //     child: ListView.separated(
                      //       shrinkWrap: true,
                      //       physics: const AlwaysScrollableScrollPhysics(),
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: 2,
                      //       itemBuilder: (context, index) {
                      //         return const Card2(
                      //           heading: 'Organization Name',
                      //           subHeading: 'Event Heading',
                      //           imageUrl: 'lib/assets/images/image1.jpg',
                      //         );
                      //       },
                      //       separatorBuilder: (context, index) {
                      //         return const SizedBox(width: 10);
                      //       },
                      //     ),
                      //   ),
                      // ),
                      const HomeStreamBuilder(
                        collectionName: 'org events',
                        queryLimit: 5,
                        heading: 'event_name',
                        subHeading: 'event_desc',
                        noDataErrorText: 'events',
                      ),
                      const SizedBox(height: 20),
                      //Browse who can you help TODO:
                      HeadingSeeAll(
                        heading: 'Browse who can you help',
                        onTap: () {
                          Get.to(() => const HomeDisplayAllEvents());
                        },
                      ),
                      const SizedBox(height: 10),

                      // check whether sized box or container TODO:
                      const HomeStreamBuilder(
                        collectionName: 'org events',
                        queryLimit: 5,
                        heading: 'event_name',
                        subHeading: 'event_desc',
                        noDataErrorText: 'recipients',
                      ),
                      const SizedBox(height: 20),

                      // Offers right now TODO:
                      HeadingSeeAll(
                        heading: 'Offers right now',
                        onTap: () {
                          Get.to(() => const HomeDisplayAllEvents());
                        },
                      ),
                      const SizedBox(height: 10),
                      // check whether sized box or container TODO:
                      const HomeStreamBuilder(
                        collectionName: 'store offers',
                        queryLimit: 5,
                        heading: 'event_name',
                        subHeading: 'event_desc',
                        noDataErrorText: 'offers',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
