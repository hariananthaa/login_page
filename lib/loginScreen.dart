import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'drawerMenu.dart';
import 'internet.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Zm5VEBydtUQKbDX59ozMHlqgwd93

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
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

  double translateX = 0.0;
  double translateY = 0.0;
  double scale = 1;
  bool toggle = false;

  //AnimationController _animationController;

  // @override
  // void initState() {
  //   _animationController =
  //       AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    void _onPressed() {
      toggle = !toggle;
      setState(() {
        if (toggle) {
          FocusScope.of(context).unfocus();
          translateX = 220;
          translateY = 180;
          scale = 0.65;
          //_animationController.forward();
        } else {
          translateX = 0.0;
          translateY = 0.0;
          scale = 1;
          //_animationController.reverse();
        }
      });
    }

    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    print(isKeyboard);
    if (toggle == true && isKeyboard == true) {
      _onPressed();
    }
    return SafeArea(
      child: Stack(
        children: [
          DrawerMenu(),
          AnimatedContainer(
            duration: Duration(milliseconds: 600),
            //transform: Matrix4.rotationX(20.0),
            transform: Matrix4.translationValues(translateX, translateY, 0)
              ..scale(scale),
            //constraints: BoxConstraints.expand(height: height, width: width),
            child: ClipRRect(
              borderRadius:
                  toggle ? BorderRadius.circular(20) : BorderRadius.circular(0),
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: true,
                  //centerTitle: true,
                  elevation: 60.0,
                  leading: IconButton(
                    // icon: AnimatedIcon(
                    //   icon: AnimatedIcons.menu_arrow,
                    //   progress: _animationController,
                    // ),
                    color: Colors.black,
                    icon: toggle ? Icon(Icons.arrow_back) : Icon(Icons.menu),
                    onPressed: () {
                      _onPressed();
                    },
                  ),
                  backgroundColor: Colors.white,
                  title: Text(
                    'MHLC',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                //backgroundColor: Colors.white,
                body: Listener(
                  onPointerMove: (moveEvent) {
                    if (toggle == true && moveEvent.delta.dx < 0) {
                      print('swipe left');
                      _onPressed();
                    }
                  },
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (!isKeyboard && toggle == true) {
                        setState(() {
                          if (toggle) {
                            translateX = 240;
                            translateY = 60;
                            scale = 0.8;
                            //_animationController.forward();
                          }
                        });
                      }
                      if (toggle == true) {
                        _onPressed();
                      }
                    },
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
                                  height: height * 0.25,
                                  width: width,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  height: height * 0.3,
                                  width: width,
                                  //color: Colors.white.withOpacity(0.3),
                                  decoration: const BoxDecoration(
                                    gradient: const LinearGradient(
                                      stops: [0.1, 0.8],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.white
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  left: 0,
                                  bottom: 25,
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
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.pink.withOpacity(0.8),
                                      Colors.transparent
                                    ],
                                  ),
                                  border: Border(
                                    left: BorderSide(
                                        color: Colors.pink, width: 5),
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                    if (!toggle) {
                                      if (formKey.currentState.validate()) {
                                        formKey.currentState.save();
                                        FocusScope.of(context).unfocus();
                                        signIn(context);
                                      }
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
