// To parse this JSON data, do
//
//     final hereLoc = hereLocFromJson(jsonString);

import 'dart:convert';

HereLoc hereLocFromJson(String str) => HereLoc.fromJson(json.decode(str));

String hereLocToJson(HereLoc data) => json.encode(data.toJson());

class HereLoc {
    List<Item> items;
    List<dynamic> queryTerms;

    HereLoc({
        required this.items,
        required this.queryTerms,
    });

    factory HereLoc.fromJson(Map<String, dynamic> json) => HereLoc(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        queryTerms: List<dynamic>.from(json["queryTerms"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "queryTerms": List<dynamic>.from(queryTerms.map((x) => x)),
    };
}

class Item {
    String title;
    String id;
    String resultType;
    String localityType;
    ItemAddress address;
    Position position;
    int distance;
    MapView mapView;
    Highlights highlights;

    Item({
        required this.title,
        required this.id,
        required this.resultType,
        required this.localityType,
        required this.address,
        required this.position,
        required this.distance,
        required this.mapView,
        required this.highlights,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        id: json["id"],
        resultType: json["resultType"],
        localityType: json["localityType"],
        address: ItemAddress.fromJson(json["address"]),
        position: Position.fromJson(json["position"]),
        distance: json["distance"],
        mapView: MapView.fromJson(json["mapView"]),
        highlights: Highlights.fromJson(json["highlights"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "resultType": resultType,
        "localityType": localityType,
        "address": address.toJson(),
        "position": position.toJson(),
        "distance": distance,
        "mapView": mapView.toJson(),
        "highlights": highlights.toJson(),
    };
}

class ItemAddress {
    String label;

    ItemAddress({
        required this.label,
    });

    factory ItemAddress.fromJson(Map<String, dynamic> json) => ItemAddress(
        label: json["label"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
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

    HighlightsAddress({
        required this.label,
    });

    factory HighlightsAddress.fromJson(Map<String, dynamic> json) => HighlightsAddress(
        label: List<Title>.from(json["label"].map((x) => Title.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "label": List<dynamic>.from(label.map((x) => x.toJson())),
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

class MapView {
    double west;
    double south;
    double east;
    double north;

    MapView({
        required this.west,
        required this.south,
        required this.east,
        required this.north,
    });

    factory MapView.fromJson(Map<String, dynamic> json) => MapView(
        west: json["west"]?.toDouble(),
        south: json["south"]?.toDouble(),
        east: json["east"]?.toDouble(),
        north: json["north"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "west": west,
        "south": south,
        "east": east,
        "north": north,
    };
}

class Position {
    double lat;
    double lng;

    Position({
        required this.lat,
        required this.lng,
    });

    factory Position.fromJson(Map<String, dynamic> json) => Position(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}
