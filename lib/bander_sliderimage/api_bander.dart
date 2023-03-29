import 'package:http/http.dart ' as http;
import 'dart:convert';

var Api_image =
    Uri.parse('https://loginuser.iceuserjunior.repl.co/imageslider');

Future<List<Bander>> getBanders() async {
  var response = await http.get(Api_image);
  if (response.statusCode == 200) {
    List<Bander> banders = banderFromJson(response.body);
    return banders;
  } else {
    throw Exception('Failed to load banders');
  }
}

List<Bander> banderFromJson(String str) =>
    List<Bander>.from(json.decode(str).map((x) => Bander.fromJson(x)));

String banderToJson(List<Bander> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bander {
  Bander({
    required this.name,
    required this.image,
  });

  String name;
  String image;

  factory Bander.fromJson(Map<String, dynamic> json) => Bander(
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
      };
}
