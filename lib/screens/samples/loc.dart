import 'dart:async';
import 'dart:convert';

import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// To parse this JSON data, do
//
//     final hereRestLocation = hereRestLocationFromJson(jsonString);

HereRestLocation hereRestLocationFromJson(String str) => HereRestLocation.fromJson(json.decode(str));

String hereRestLocationToJson(HereRestLocation data) => json.encode(data.toJson());

class HereRestLocation {
    List<Item> items;

    HereRestLocation({
        required this.items,
    });

    factory HereRestLocation.fromJson(Map<String, dynamic> json) => HereRestLocation(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

//from here
// Future<http.Response> fetchHereRestLocation(http.Client client) async {
//   return client.get(Uri.parse('https://discover.search.hereapi.com/v1/discover?at=40.7307999,-73.9973085&limit=2&q=Liberty&apiKey=**My API key here**'));
// }

List <HereRestLocation> parseHereRestLocation(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<HereRestLocation>((json) => HereRestLocation.fromJson(json)).toList();
}

Future <List<HereRestLocation>> fetchHereRestLocation(http.Client client) async {
  final response = await client.get(Uri.parse('https://autosuggest.search.hereapi.com/v1/autosuggest?at=6.93194,79.84778&lang=en&q=kadaw&limit=3&apiKey=1AO6iReaNI4Mxj8I0RO-NMUniTyNhfQS3dKV9wQMjIM'));
  // return parseHereRestLocation(response.body);
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseHereRestLocation,response.body);
}

//to here
class Item {
    String title;
    String id;
    String language;
    String resultType;
    String localityType;
    ItemAddress address;
    Highlights highlights;

    Item({
        required this.title,
        required this.id,
        required this.language,
        required this.resultType,
        required this.localityType,
        required this.address,
        required this.highlights,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        id: json["id"],
        language: json["language"],
        resultType: json["resultType"],
        localityType: json["localityType"],
        address: ItemAddress.fromJson(json["address"]),
        highlights: Highlights.fromJson(json["highlights"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "language": language,
        "resultType": resultType,
        "localityType": localityType,
        "address": address.toJson(),
        "highlights": highlights.toJson(),
    };
}

class ItemAddress {
    String label;
    String countryCode;
    String countryName;
    String state;
    String county;
    String city;

    ItemAddress({
        required this.label,
        required this.countryCode,
        required this.countryName,
        required this.state,
        required this.county,
        required this.city,
    });

    factory ItemAddress.fromJson(Map<String, dynamic> json) => ItemAddress(
        label: json["label"],
        countryCode: json["countryCode"],
        countryName: json["countryName"],
        state: json["state"],
        county: json["county"],
        city: json["city"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "countryCode": countryCode,
        "countryName": countryName,
        "state": state,
        "county": county,
        "city": city,
    };
}

class Highlights {
    List<Title> title;
    HighlightsAddress address;

    Highlights({
        required this.title,
        required this.address,
    });

    factory Highlights.fromJson(Map<String, dynamic> json) => Highlights(
        title: List<Title>.from(json["title"].map((x) => Title.fromJson(x))),
        address: HighlightsAddress.fromJson(json["address"]),
    );

    Map<String, dynamic> toJson() => {
        "title": List<dynamic>.from(title.map((x) => x.toJson())),
        "address": address.toJson(),
    };
}

class HighlightsAddress {
    List<Title> label;
    List<Title> city;

    HighlightsAddress({
        required this.label,
        required this.city,
    });

    factory HighlightsAddress.fromJson(Map<String, dynamic> json) => HighlightsAddress(
        label: List<Title>.from(json["label"].map((x) => Title.fromJson(x))),
        city: List<Title>.from(json["city"].map((x) => Title.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "label": List<dynamic>.from(label.map((x) => x.toJson())),
        "city": List<dynamic>.from(city.map((x) => x.toJson())),
    };
}

class Title {
    int start;
    int end;

    Title({
        required this.start,
        required this.end,
    });

    factory Title.fromJson(Map<String, dynamic> json) => Title(
        start: json["start"],
        end: json["end"],
    );

    Map<String, dynamic> toJson() => {
        "start": start,
        "end": end,
    };
}



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Isolate Demo';

    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(child: InputButton1(onTap: fetch, text: 'text')));
  }
}
Future<HereRestLocation> fetch() async {
    final response = await http.get(Uri.parse('https://autosuggest.search.hereapi.com/v1/autosuggest?at=6.93194,79.84778&lang=en&q=kadaw&limit=3&apiKey=1AO6iReaNI4Mxj8I0RO-NMUniTyNhfQS3dKV9wQMjIM'));

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      HereRestLocation hereRestLocation = HereRestLocation.fromJson(jsonResponse);

      for (Item item in hereRestLocation.items) {
        debugPrint(item.id.toString());
      }

      return hereRestLocation;
    } else {
      throw Exception("Something Went Wrong");
    }
  }
  

class MapList extends StatelessWidget {
  const MapList({super.key, required this.items});

  final List<HereRestLocation> items;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: InputButton1(onTap: fetch, text: 'text')),);
  }
}