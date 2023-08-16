import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/Activity/donate%20items/view_donatables_det.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewDonatablesApprovalItem extends StatefulWidget {
  const ViewDonatablesApprovalItem({super.key});

  @override
  State<ViewDonatablesApprovalItem> createState() => _ViewDonatablesApprovalItemState();
}

class _ViewDonatablesApprovalItemState extends State<ViewDonatablesApprovalItem> {
  @override
  void initState() {
    super.initState();
  }

  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

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
                Get.arguments[1].toString(),
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
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 80),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: InputButton1(
                                  onTap: () {
                                    Get.to(
                                        () =>
                                            const ViewDonatablesItemItemDetails(),
                                            // 0 - item id
                                        arguments: [Get.arguments[0]]);
                                  },
                                  text: 'View details',
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
            ],
          ),
        ),
      ),
    );
  }
}
