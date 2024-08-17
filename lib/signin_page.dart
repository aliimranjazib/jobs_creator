import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobs_creator/common_input_area.dart';
import 'package:jobs_creator/home_page.dart';
import 'package:jobs_creator/navigator.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOGIN HERE",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            InputField(
              controller: emailController,
              labelText: "enter your email",
            ),
            SizedBox(height: 30),
            InputField(
              controller: passwordController,
              labelText: "enter your  password",
            ),
            SizedBox(height: 30),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text)
                    .whenComplete(() {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("You have sucessfully logged in")));
                  gotoNextPage(context, HomePage());
                });
              },
              minWidth: double.infinity,
              splashColor: Colors.amber,
              color: Colors.green,
              shape: StadiumBorder(),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("LOGIN"),
              ),
            ),
            SizedBox(height: 30),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Do not have an account? Signup here",
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
