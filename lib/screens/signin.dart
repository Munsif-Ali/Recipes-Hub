import 'package:bs_project/screens/homescree.dart';
import 'package:bs_project/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
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
                        controller: emailController,
                        onSaved: (value) {
                          emailController.text = value!;
                        },
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
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          prefixIconColor: Theme.of(context).primaryColor,
                          prefixIcon: Icon(
                            Icons.email,
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
                        controller: passwordController,
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
                        onSaved: (newValue) =>
                            passwordController.text = newValue!,
                        decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          hintText: "Enter your Password",
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
                  signIn(emailController.text, passwordController.text);
                },
                child: const Text(
                  "Log In",
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
                    return SignUp();
                  }));
                },
                child: const Text(
                  "Create Account",
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

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Fluttertoast.showToast(msg: "Login Successful");
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return  HomeScreen();
        }));
      }).catchError((error) {
        Fluttertoast.showToast(msg: error.message);
      });
    }
  }
}
