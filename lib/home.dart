import 'package:flutter/material.dart';
import 'package:login_api_nodejs/bander_sliderimage/slider_image.dart';
import 'package:login_api_nodejs/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_api_nodejs/shop_show/show_list.dart';

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({super.key, required this.token});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map? data;

  Future<Map?> getUserData() async {
    final response = await http.get(
      Uri.parse('https://loginpost.iceuserjunior.repl.co/user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }


  @override
  void initState() {
    super.initState();
    getUserData().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            header(),
            Imageslider(),
          ],
        ),
      ),
    );
  }

  Widget Avatar() {
    return
      ElevatedButton(
        child: data == null
            ? CircleAvatar(
        backgroundColor: Colors.blue
      )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
              NetworkImage(data?['imgprofile'] ?? ''),
              radius: 25,
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage(token: widget.token)),
          );
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(CircleBorder()),),
      );
  }

  Widget show_name() {
    return
      Text(
        '${data?['nickname'] ?? ''}',
        style: TextStyle(fontSize: 20, color: Colors.blue),
      );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10)
      ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  show_name(),
                  SizedBox(width: 150,),
                  Avatar()
                ],
              )
            ],
          ),
      ),
    );
  }

}
