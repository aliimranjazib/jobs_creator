import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobs_creator/common_input_area.dart';
import 'package:jobs_creator/navigator.dart';
import 'package:jobs_creator/signin_page.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Signup Page",
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
            InputField(
              controller: confirmPasswordController,
              labelText: "enter your  confirm password",
            ),
            SizedBox(height: 30),
            MaterialButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  )
                      .whenComplete(() {
                    gotoNextPage(context, SignInPage());
                  });
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              minWidth: double.infinity,
              splashColor: Colors.amber,
              color: Colors.green,
              shape: StadiumBorder(),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("SIGN UP"),
              ),
            ),
            SizedBox(height: 30),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ));
                },
                child: Text(
                  "Already have an account? Login here",
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
