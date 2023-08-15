import 'package:donatem/screens/main/additem/cat_grids/clothing_and_accessories.dart';
import 'package:donatem/screens/main/additem/cat_grids/electronics_and_appliances.dart';
import 'package:donatem/screens/main/additem/cat_grids/household_items.dart';
import 'package:donatem/screens/main/additem/cat_grids/other.dart';
import 'package:donatem/screens/main/additem/cat_grids/stationeries.dart';
import 'package:donatem/screens/main/additem/cat_grids/toys_and_games.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ItemCategory extends StatefulWidget {
  // Item Id
  // final String itemDocId;

  const ItemCategory({super.key});

  @override
  State<ItemCategory> createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {


  int _selectedIndex = 0;

  // Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  

  // Next method
  Future nextStep(String categoryName) async {
    // show loading icon
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    // await FirebaseFirestore.instance
    //     .collection('donation items')
    //     .doc(uid)
    //     .set(
    //   {
    //     'item_category': categoryName,
    //   },
    //   SetOptions(merge: true),
    // );
    //pop loading circle
    Navigator.pop(context);
    // {
    //   // await Navigator.push(context, MaterialPageRoute(
    //   //   builder: (context) {
    //   //     return ItemTags(itemDocId: uid);
    //   //   },
    //   // ));
    //   Get.to(()=> const ItemPhotoVerifyNotice(), arguments: [Get.arguments[0].toString()]);
    // }
  }

  passDocId() {
    return (uid).toString();
  }

  // var data = Get.arguments;

  late final List<Widget> _widgetOptions = <Widget>[
    ClothingAndAccessories(itemDocId: Get.arguments[0]),
    HouseholdItems(itemDocId: Get.arguments[0]),
    ElectronicsAndAppliances(itemDocId: Get.arguments[0]),
    Stationeries(itemDocId: Get.arguments[0]),
    ToysAndGames(itemDocId: Get.arguments[0]),
    Other(itemDocId: Get.arguments[0]),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple.shade300,
        elevation:0.0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Drawer(
                elevation: 0,
                backgroundColor: Colors.deepPurple[100],
                child: ListTileTheme(
                  selectedColor: Colors.black,
                  selectedTileColor: Colors.white,
                  // tileColor: Colors.amber,
                  // color: Colors.deepPurple[100],
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ListTile(
                        title: const Text('Clothing and Accessories'),
                        selected: _selectedIndex == 0,
                        onTap: () {
                          _onItemTapped(0);
                        },
                      ),
                      ListTile(
                        // selectedTileColor: Colors.amber,
                        title: const Text('Household Accessories'),
                        selected: _selectedIndex == 1,
                        onTap: () {
                          _onItemTapped(1);
                        },
                      ),
                      ListTile(
                        // selectedTileColor: Colors.amber,
                        title: const Text('Electronics and Appliances'),
                        selected: _selectedIndex == 2,
                        onTap: () {
                          _onItemTapped(2);
                        },
                      ),
                      ListTile(
                        // selectedTileColor: Colors.amber,
                        title: const Text('Stationeries'),
                        selected: _selectedIndex == 3,
                        onTap: () {
                          _onItemTapped(3);
                        },
                      ),
                      ListTile(
                        // selectedTileColor: Colors.amber,
                        title: const Text('Toys and Games'),
                        selected: _selectedIndex == 4,
                        onTap: () {
                          _onItemTapped(4);
                        },
                      ),
                      ListTile(
                        // selectedTileColor: Colors.amber,
                        title: const Text('Other'),
                        selected: _selectedIndex == 5,
                        onTap: () {
                          _onItemTapped(5);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: _widgetOptions[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}
