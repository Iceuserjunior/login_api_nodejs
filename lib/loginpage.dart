import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/api_post.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  static var _openpassword = true;

  @override
  void initState() {
    super.initState();
    _openpassword;
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              logo_login(),
              space(),
              const Text(
                'LoginUser',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.blue,
                ),
              ),
              space(),
              username_login(),
              space(),
              password_login(),
              space(),
              button_login(),
              space(),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  token: token,
                )),
        (Route<dynamic> route) => false,
      );
    }
  }



  Widget logo_login() {
    return
    Image.asset(
      'assets/airplane.png',
      width: 100,
      height: 100,
    );
  }

  Widget username_login() {
    return
    TextFormField(
      controller: _usernameController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Username',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade900),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        prefixIcon: Icon(Icons.person),
      ),
    );
  }

  Widget password_login() {
    return
    TextFormField(
      controller: _passwordController,
      obscureText: _openpassword,
      decoration: InputDecoration(
          labelText: 'Password',
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue.shade900),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: _openpassword
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
            onPressed: () {
              setState(() {
                _openpassword = !_openpassword;
              });
            },
          )),
    );
  }

  Widget space() {
    return SizedBox(height: 30);
  }

  Widget button_login() {
    return
    ElevatedButton(
      onPressed: _submit,
      child: Text('Login'),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(400, 55)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  Future<void> _submit() async {
    setState(() {
      _errorMessage = null;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both username and password';
      });
      return;
    }

    try {
      final token = await loginUser(username, password);
      if (token != null) {
        await saveToken(token);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    token: token,
                  )),
          (Route<dynamic> route) => false,
        );
      } else {
        setState(() {
          _errorMessage = 'Invalid username or password';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }
}
