import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/additem/photos%20upload/donation_photo_auth.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Others
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PhotoUploadUI1 extends StatefulWidget {
  const PhotoUploadUI1({super.key});

  @override
  State<PhotoUploadUI1> createState() => _PhotoUploadUI1State();
}

class _PhotoUploadUI1State extends State<PhotoUploadUI1> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  bool uploadStatus = false;
  // final

  // For firebase storage
  // final uploadPath = '/Donation Items/Item Images';
  // final ref = FirebaseStorage.instance.ref().child('/Donation Items/Item Images');
  // FirebaseStorage storage = FirebaseStorage.instance;
  // Reference ref =
      // FirebaseStorage.instance.ref().child('/Donation Items/Item Images');
  UploadTask? uploadTask;

  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  Future<void> _uploadImageFirebase() async {
    final path = '/Donation Items/Item Images/${DateTime.now().millisecondsSinceEpoch.toString()}${uid.toString()}';
    final file;

    final ref = FirebaseStorage.instance.ref().child(path);
    if (_croppedFile == null) {
      file = File(_pickedFile!.path);
      uploadTask = ref.putFile(file);
    } else {
      file = File(_croppedFile!.path);
      uploadTask = ref.putFile(file);
    }
    toggleUploadStatus();

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('donation items')
        .doc(Get.arguments[0])
        .set(
      {
        'item_image_url_' + Get.arguments[1]: urlDownload,
        'image_count': int.parse(Get.arguments[1]),
        'status':2,
        'assigned_status':0,
      },
      SetOptions(merge: true),
    );

    print('Download-Link: $urlDownload');
  }

  void toggleUploadStatus() {
    setState(() {
      uploadStatus = !uploadStatus;
    });
  }



  //Go next
  void next() {
    Get.to(() => const DonationPhotoAuth(),
        arguments: [Get.arguments[0].toString()]);
  }

  Widget _imageCardUpload() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          // _menu(),
          _buildProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return StreamBuilder<TaskSnapshot>(
        stream: uploadTask!.snapshotEvents,
        builder: (context, snapshot) {
          double progress = snapshot.hasData
              ? snapshot.data!.bytesTransferred / snapshot.data!.totalBytes
              : 0;
          return Column(
            children: [
              LinearPercentIndicator(
                barRadius: const Radius.circular(20.0),
                percent: progress,
                progressColor: Colors.deepPurple.shade300,
                backgroundColor: Colors.deepPurple.shade100,
                animation: true,
                animationDuration: 1000,
                lineHeight: 25.0,
                center: Text('${(progress * 100).toStringAsFixed(2)} % '),
              ),
              const SizedBox(height: 50.0),
              Align(child: InputButton1(onTap: next, text: 'Next'))
            ],
          );
        });
  }

  Widget _body() {
    if (_croppedFile != null || _pickedFile != null) {
      if (uploadStatus) {
        return _imageCardUpload();
      } else {
        return _imageCard();
      }
    } else {
      return _uploaderCard();
    }
  }

  Widget _imageCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _menu(),
        ],
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: Image.file(File(path)),
      );
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () {
            _clear();
          },
          backgroundColor: Colors.redAccent,
          tooltip: 'Delete',
          child: const Icon(Icons.delete),
        ),
        if (_croppedFile == null)
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              onPressed: () {
                _cropImage();
              },
              backgroundColor: Colors.deepPurple.shade300,
              tooltip: 'Crop',
              child: const Icon(Icons.crop),
            ),
          ),
        const SizedBox(width: 30.0),
        FloatingActionButton(
          onPressed: () {
            _uploadImageFirebase();
          },
          backgroundColor: Colors.deepPurple.shade300,
          tooltip: 'Upload',
          child: const Icon(Icons.upload_file),
        ),
      ],
    );
  }

  //1st view
  Widget _uploaderCard() {
    return Center(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    radius: const Radius.circular(12.0),
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    color: Colors.deepPurple.shade200,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.deepPurple.shade200,
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            'Upload an image to start',
                            style: TextStyle(
                              color: Colors.deepPurple.shade200,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            Get.arguments[1] + '/3',
                            style: TextStyle(
                              color: Colors.deepPurple.shade200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _uploadCameraImage();
                            },
                            child: const Text('Camera'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple.shade400,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _uploadImage();
                            },
                            child: const Text('Gallery'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple.shade400,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepPurple.shade300,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  Future<void> _uploadCameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _body(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
