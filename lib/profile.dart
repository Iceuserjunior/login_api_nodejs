import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_api_nodejs/bander_sliderimage/slider_image.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String token;

  const ProfilePage({Key? key, required this.token}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: data == null
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Avatar(),
            SizedBox(height: 20),
            show_name(),
            SizedBox(height: 20),
            log_out(),
          ],
    ),
      ),
    );
  }
  Future<void> logOut() async {
    // ลบค่า token ออกจาก SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    // เปลี่ยนหน้าไปยังหน้า login
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  Widget log_out() {
  return
  ElevatedButton(
  onPressed: logOut,
  child: Text('Login'),
  style: ButtonStyle(
  minimumSize: MaterialStateProperty.all(Size(200, 55)),
  shape: MaterialStateProperty.all(
  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
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
              radius: 100,
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
        style: TextStyle(fontSize: 30, color: Colors.black54),
      );
  }

}

