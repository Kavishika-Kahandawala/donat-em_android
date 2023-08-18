import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/org%20ui/org%20event%20accept%20item/scan_org_event_match_item_det.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ScanQROrgEventViewReceiveMatchedItem extends StatefulWidget {
  const ScanQROrgEventViewReceiveMatchedItem({super.key});

  @override
  State<ScanQROrgEventViewReceiveMatchedItem> createState() => _ScanQROrgEventViewReceiveMatchedItemState();
}

class _ScanQROrgEventViewReceiveMatchedItemState extends State<ScanQROrgEventViewReceiveMatchedItem> {
  @override
  void initState() {
    getDetails();
    key=Get.arguments[0].toString();
    super.initState();
  }

  Future getDetails()async{
    await FirebaseFirestore.instance
        .collection('donation items')
        .doc(Get.arguments[0].toString())
        .get()
        .then((querySnapshot) {
      setState(() {
        productName = querySnapshot.get('product_name');
      });
    });
  }

  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  String productName='';
  String key='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Back'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple.shade300,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                productName,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 60),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('donation items')
                    .where(FieldPath.documentId,
                        isEqualTo: Get.arguments[0].toString())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: Colors.deepPurple,
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Text('No data available.');
                  }

                  final List<DocumentSnapshot> documents = snapshot.data!.docs;

                  final doc = documents[0];
                  final imageUrl1 = doc['item_image_url_1'] ?? '';
                  final imageUrl2 = doc['item_image_url_2'] ?? '';
                  final imageUrl3 = doc['item_image_url_3'] ?? '';

                  final imageUrls = [imageUrl1, imageUrl2, imageUrl3]
                      .where((url) => url.isNotEmpty)
                      .toList();

                  return Expanded(
                    child: SizedBox(
                      height: 200, // Adjust the height as needed
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: imageUrls.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final imageUrl = imageUrls[index];

                          return Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                child: Image.network(imageUrl),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Image ${index + 1} of ${imageUrls.length}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: InputButton1(
                  onTap: () {
                    Get.to(() => const ScanQROrgEventViewItemDetails(),
                        // 0 - item id , 1- doc id
                        arguments: [
                          Get.arguments[0].toString(),
                        ]);
                  },
                  text: 'View details',
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
