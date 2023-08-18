// import 'dart:convert';

// import 'package:donatem/screens/main/maps/here_json_format.dart';
// import 'package:donatem/screens/main/maps/remote_service.dart';
// import 'package:donatem/screens/samples/maps_search.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class MapTestSearch extends StatefulWidget {
//   const MapTestSearch({super.key});

//   @override
//   State<MapTestSearch> createState() => _MapTestSearchState();
// }

// class _MapTestSearchState extends State<MapTestSearch> {
//   List<HereRestLocation>? locationDetails;
//   var isLoaded = false;

//   @override
//   void initState() {
//     getData();
//     // getActivities();
//     super.initState();
//   }

//   // getData()async{
//   //   locationDetails = (await RemoteService().fetchLocations()) as List<HereRestLocation>?;
//   //   if(locationDetails != null){
//   //     setState(() {
//   //       isLoaded = true;
//   //     });
//   //   }
//   // }

//   getData() async {
//     var client = http.Client();
//     var uri = await Uri.parse(
//         "https://autosuggest.search.hereapi.com/v1/autosuggest?at=52.5199813,13.3985138&lang=en&q=kadawatha&apiKey=1AO6iReaNI4Mxj8I0RO-NMUniTyNhfQS3dKV9wQMjIM");
//     var response = await client.get(uri);

//     // List data = jsonDecode(response.body);

//     if (response.statusCode == 200) {
//       var json = response.body;
//       var res = jsonDecode(json)['items'] as List;
//       print(res);
//     }
//   }

//   // void getActivities() async {
//   //   var searchResult = await http.get(Uri.parse('https://autocomplete.search.hereapi.com/v1/autocomplete?q=Kadawatha&limit=2&apiKey=1AO6iReaNI4Mxj8I0RO-NMUniTyNhfQS3dKV9wQMjIM'));
//   //   // var result = jsonDecode(searchResult.body)['items'];
//   //   var data =  jsonDecode(searchResult.body);
//   //   var res = data['items'] as List ;
//   //   print(res);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Map Test Search'),
//         ),
//         body: Visibility(
//           visible: isLoaded,
//           replacement: const Center(child: CircularProgressIndicator()),
//           child: ListView.builder(
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 return Container(
//                   child: Text('locationDetails![index].items[0].title'),
//                 );
//               }),
//         ));
//   }
// }
