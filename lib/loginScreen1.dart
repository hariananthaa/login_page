import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'internet.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Zm5VEBydtUQKbDX59ozMHlqgwd93

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _mail;
  String _password;

  void signIn(BuildContext context) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _mail, password: _password)
        .catchError((onError) {
      print(onError);
    }).then((authUser) {
      print(authUser.user.uid);
      if (authUser.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailValidation = MultiValidator([
    EmailValidator(errorText: 'Invalid Email'),
    RequiredValidator(errorText: 'Email is Required'),
    MaxLengthValidator(50, errorText: 'Email should be less than 50 Charactor'),
  ]);

  final passwordValidation = MultiValidator([
    RequiredValidator(errorText: 'Password is Required'),
    MaxLengthValidator(50,
        errorText: 'Password should be less than 50 Charactor'),
    MinLengthValidator(8, errorText: 'Password should be at least 8 Charactor'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Passwords must have at least one special character'),
  ]);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Image.asset(
                        imagePath,
                        //scale: 1.0,
                        height: height * 0.4,
                        width: width,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: height * 0.45,
                        width: width,
                        //color: Colors.white.withOpacity(0.3),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            stops: [0.1, 0.8],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.white],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        left: 0,
                        bottom: 30,
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                appName,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                slogan,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.pink.withOpacity(0.8),
                            Colors.transparent
                          ],
                        ),
                        border: Border(
                          left: BorderSide(color: Colors.pink, width: 5),
                        ),
                      ),
                      child: Text(
                        " LOGIN    ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autofocus: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: emailValidation,
                      onSaved: (value) {
                        _mail = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.pink,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.pink,
                        ),
                        labelText: "Email Address",
                        labelStyle: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autofocus: false,
                      onSaved: (value) {
                        _password = value;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: passwordValidation,
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.pink,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.lock_open,
                          color: Colors.pink,
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: height * 0.08,
                      width: width - 30,
                      child: MaterialButton(
                        color: Colors.pink.withOpacity(0.7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            FocusScope.of(context).unfocus();
                            signIn(context);
                            // if (_mail == 'hari@gmail.com' &&
                            //     _password == '12345678@') {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => Internet()));
                            //   FocusScope.of(context).unfocus();
                            // }
                            // print('Valid');
                            // print(_mail);
                            // print(_password);

                            ///print(formKey.currentContext.toString());
                            //harihprint('Mail Id: $mail');
                          }
                        },
                        child: Text(
                          "Login to Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "I don't have an account?  ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
