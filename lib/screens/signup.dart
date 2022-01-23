import 'package:bs_project/model/user_model.dart';
import 'package:bs_project/screens/homescree.dart';
import 'package:bs_project/screens/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                "assets/images/logo2.png",
                width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: TextFormField(
                        onSaved: (newValue) => nameController.text = newValue!,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{5,}$');
                          if (value!.isEmpty) {
                            return "Name can not be empty";
                          }
                          if (!regex.hasMatch(value)) {
                            return "Please Enter valid Name(Min. 5 Characters)";
                          }
                          return null;
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Enter your full name",
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          prefixIconColor: Theme.of(context).primaryColor,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return "Please Enter a valid email";
                          }
                          return null;
                        },
                        onSaved: (newValue) => emailController.text = newValue!,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          hintText: "Enter your email",
                          filled: true,
                          fillColor: Colors.white,
                          iconColor: Theme.of(context).primaryColor,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).primaryColor,
                          ),
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: TextFormField(
                        onSaved: (newValue) =>
                            passwordController.text = newValue!,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return "Password is required ";
                          }
                          if (!regex.hasMatch(value)) {
                            return "Please Enter valid Password(Min. 6 Characters)";
                          }
                          return null;
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          hintText: "Enter Password",
                          filled: true,
                          fillColor: Colors.white,
                          iconColor: Theme.of(context).primaryColor,
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Theme.of(context).primaryColor,
                          ),
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: TextFormField(
                        onSaved: (newValue) =>
                            confirmController.text = newValue!,
                        validator: (value) {
                          if (value != passwordController.text) {
                            return "Password dont math";
                          }
                          return null;
                        },
                        controller: confirmController,
                        decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          hintText: "Confirm Password",
                          filled: true,
                          fillColor: Colors.white,
                          iconColor: Theme.of(context).primaryColor,
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Theme.of(context).primaryColor,
                          ),
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FlatButton(
                color: Colors.white,
                onPressed: () {
                  signUp(emailController.text, passwordController.text);
                },
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Color(0xFFED6E39),
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FlatButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return SignIn();
                  }));
                },
                child: const Text(
                  "Already have Account",
                  style: TextStyle(
                    color: Color(0xFFED6E39),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((error) {
        Fluttertoast.showToast(msg: error.message);
      });
    }
  }

  postDetailsToFirestore() async {
    print("account jor sha");
    Fluttertoast.showToast(msg: "Account Created Succesfully");
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.name = nameController.text;
    userModel.uid = user.uid;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }), (route) => false);
  }
}
