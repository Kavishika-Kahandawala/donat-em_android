import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('donate history')
            .where('assigned_to', isEqualTo: 'FKIcVLadXuNgiKgtHL4m4Q7eiU72')
            .where('date', isGreaterThan: DateTime.now().subtract(Duration(days: 30)))
            .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text('No documents found.');
            }

            List<String> documentIds = snapshot.data!.docs
              .map((doc) => doc.id)
              .toList();

            return ListView.builder(
              itemCount: documentIds.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(documentIds[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(); 
  runApp(MyApp());
}
