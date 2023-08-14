// import 'dart:convert';

// https://autosuggest.search.hereapi.com/v1/autosuggest?at=6.93194,79.84778&lang=en&q=kadaw&limit=3&apiKey=1AO6iReaNI4Mxj8I0RO-NMUniTyNhfQS3dKV9wQMjIM
// import 'package:donatem/screens/main/maps/here_json_format.dart';
// import 'package:http/http.dart' as http;

// class RemoteService {
//   Future<HereRestLocation> fetchLocations() async {
//     var client = http.Client();
//     var uri = await Uri.parse("https://autosuggest.search.hereapi.com/v1/autosuggest?at=52.5199813,13.3985138&lang=en&q=kadawatha&apiKey=1AO6iReaNI4Mxj8I0RO-NMUniTyNhfQS3dKV9wQMjIM");
//     var response = await client.get(uri);

//     // List data = jsonDecode(response.body);

//     if (response.statusCode == 200) {
//       var json = response.body;
//       print(await hereRestLocationFromJson(json));
//       return hereRestLocationFromJson(json);
//     } else {
//       throw Exception("Something Went Wrong");
//     }
//   }
// }
