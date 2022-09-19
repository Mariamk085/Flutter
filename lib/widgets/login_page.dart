import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ttranport_01/theme.dart';
import 'package:ttranport_01/widgets/Home01.dart';
import 'package:ttranport_01/widgets/forget_password.dart';
import 'package:ttranport_01/widgets/header.dart';
import 'package:http/http.dart';
import 'package:ttranport_01/Api/loginresponse.dart';
import 'package:ttranport_01/Api/progresshub.dart';
import 'package:ttranport_01/common/theme_helper.dart';
import 'package:ttranport_01/widgets/loading.dart';

import 'registration_page.dart';
import "package:google_sign_in/google_sign_in.dart";

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  bool _isnumbers = false;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  bool isloading = false;
  Key _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  LoginRequestModel requestModel = LoginRequestModel();

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  bool isApiCallProcess = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  onChangedPassword(String password) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child:
                  HeaderWidget(_headerHeight, true, Icons.gps_fixed_outlined),
            ),
            SafeArea(
              child: isloading
                  ? const Loading()
                  : Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      margin: EdgeInsets.fromLTRB(
                          20, 10, 20, 10), // This will be the login form
                      child: Column(
                        children: [
                          Text(
                            'University of Gujrat!',
                            style: TextStyle(
                                fontSize: 60,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 30.0),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    child: TextFormField(
                                        controller: _emailController,
                                        decoration: ThemeHelper()
                                            .textInputDecoration('User Name',
                                                'Enter your user name'),
                                        validator: (value) {
                                          if (value!.isNotEmpty &&
                                              value.length > 2) {
                                            return null;
                                          } else if (value.length < 3 &&
                                              value.isNotEmpty) {
                                            return 'Enter you valid Email ';
                                          } else {
                                            return "Enter Your Email";
                                          }
                                        }),
                                    decoration: ThemeHelper()
                                        .inputBoxDecorationShaddow(),
                                  ),
                                  SizedBox(height: 30.0),
                                  Container(
                                    child: TextFormField(
                                        onChanged: (password) =>
                                            onChangedPassword(password),
                                        controller: _passwordController,
                                        obscureText: true,
                                        decoration: ThemeHelper()
                                            .textInputDecoration('Password',
                                                'Enter your password'),
                                        validator: (value) {
                                          if (value!.isNotEmpty &&
                                              value.length > 2) {
                                            return null;
                                          } else if (value.length < 3 &&
                                              value.isNotEmpty) {
                                            return 'Enter your valid Password ';
                                          } else {
                                            return "Enter Your Password";
                                          }
                                        }),
                                    decoration: ThemeHelper()
                                        .inputBoxDecorationShaddow(),
                                  ),
                                  SizedBox(height: 15.0),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPasswordPage()),
                                        );
                                      },
                                      child: Text(
                                        "Forgot your password?",
                                        style: TextStyle(
                                          color: Colors.lightBlue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: ThemeHelper()
                                        .buttonBoxDecoration(context),
                                    child: ElevatedButton(
                                      style: ThemeHelper().buttonStyle(),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(40, 10, 40, 10),
                                        child: Text(
                                          'Sign In'.toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isloading = true;
                                        });
                                        var _email = email.text;
                                        var _password = password.text;
                                        requestModel.email = _email;
                                        requestModel.password = _password;
                                        postData(_email, _password);
                                      },

                                      //After successful login we will redirect to profile page. Let's create profile page now
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                    //child: Text('Don\'t have an account? Create'),
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "Don\'t have an account? "),
                                      TextSpan(
                                        text: 'signup',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegistrationPage()));
                                          },
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                    ])),
                                  ),
                                ],
                              )),
                        ],
                      )),
            ),
          ],
        ),
      ),
    );
  }

  final url =
      "http://api.cwiztech.com:8080/v1/oauth/token?username=uog&password=UOG123&grant_type=password";

  void postData(String email, String password) async {
    var jsonData = null;

    final response = await post(Uri.parse(url), body: {
      'email': email.trim(),
      'password': password.trim(),
    }, headers: {
      'Authorization': 'Basic VXNlck1hbmFnbWVudDpzZWNyZXQ='
    });
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      setState(() {
        isloading = false;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
      });
    } else {
      print(response.body);
    }
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    bool check = true;
    if (form != null) {
      check = form.validate();
    }
    if (check) {
      form?.save();
      return true;
    }
    return false;
  }
}
