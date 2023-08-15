import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/rec%20reg/rec_reg_thanks.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RecRegCatSelect extends StatefulWidget {
  const RecRegCatSelect({super.key});

  @override
  State<RecRegCatSelect> createState() => _RecRegCatSelectState();
}
class _RecRegCatSelectState extends State<RecRegCatSelect> {
  List<Object?> selectedItems = [];

  final List<MultiSelectItem<String>> _items = [
    MultiSelectItem<String>('Clothing and Accessories', 'Clothing and Accessories'),
    MultiSelectItem<String>('Household Accessories', 'Household Accessories'),
    MultiSelectItem<String>('Electronics and Appliances', 'Electronics and Appliances'),
    MultiSelectItem<String>('Stationeries', 'Stationeries'),
    MultiSelectItem<String>('Toys and Games', 'Toys and Games'),
  ];

  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  String catError='';

  Future setCats() async {
    if (selectedItems.isNotEmpty) {
      setState(() {
        catError='';
      });
      await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(
      {
        'rec_cats':selectedItems,
      },
      SetOptions(merge: true),
    );
    await finalizeData();
    await Get.to(() => const RecRegThanks());
    }else{
      setState(() {
        catError='Please select at least one category';
      });
    }
  }

  Future finalizeData()async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'receiver_reg_status': 2,
      },
      SetOptions(merge: true),
    );
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple.shade300,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Categories',
                style: GoogleFonts.poppins(
                  // fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Select categories which you are interested in for donations',
                style: GoogleFonts.poppins(
                  // fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),

              // multi select
              MultiSelectBottomSheetField(
                selectedColor: Colors.deepPurple.shade300,
                selectedItemsTextStyle:
                    GoogleFonts.poppins(color: Colors.white),
                // backgroundColor: Colors.deepPurple.shade100,
                backgroundColor: Colors.white,
                initialChildSize: 0.4,
                listType: MultiSelectListType.CHIP,
                searchable: true,
                buttonText: Text(
                  "Select categories",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                  ),
                ),
                buttonIcon: Icon(
                  LineIcons.list,
                  color: Colors.deepPurple.shade300,
                ),
                title: Text(
                  "Select categories",
                  style: GoogleFonts.poppins(),
                ),
                decoration: BoxDecoration(
                  // color: Colors.blue.withOpacity(0.1),
                  color: Colors.white, //button color
                  borderRadius: BorderRadius.circular(8), //ci
                  border: Border.all(
                    color: Colors.deepPurple.shade300,
                    width: 1.5,
                  ),
                ),
                items: _items,
                onConfirm: (values) {
                  setState(
                    () {
                      selectedItems = values;
                      catError='';
                    },
                  );
                },
                chipDisplay: MultiSelectChipDisplay(
                  onTap: (value) {
                    setState(() {
                      selectedItems.remove(value);
                    });
                  },
                ),
              ),
              selectedItems.isEmpty
                  ? Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            "None selected",
                            style: GoogleFonts.poppins(color: Colors.black54),
                          ),
                        ],
                      ),
                    )
                  : Container(),

                  const SizedBox(height: 50),
                  Text(catError, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 20),
                  InputButton1(onTap: setCats, text: 'Next')
            ],
          ),
        ),
      ),
    );
  }
}
