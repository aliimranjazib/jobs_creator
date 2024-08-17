import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobs_creator/common_input_area.dart';

class AddJobsPage extends StatelessWidget {
  AddJobsPage({super.key});

  TextEditingController jobTileController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController timeStampController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "ADD YOUR JOB",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          InputField(
            controller: jobTileController,
            labelText: "Job Tile",
          ),
          SizedBox(height: 30),
          InputField(
            controller: detailController,
            labelText: "Job detail",
          ),
          SizedBox(height: 30),
          InputField(
            controller: timeStampController,
            labelText: "time",
          ),
          SizedBox(height: 30),
          MaterialButton(
            onPressed: () {
              FirebaseFirestore.instance.collection("jobs").add({
                "job_title": jobTileController.text,
                "details": detailController.text,
              }).whenComplete(() {
                Navigator.pop(context);
              });
            },
            minWidth: double.infinity,
            splashColor: Colors.amber,
            color: Colors.green,
            shape: StadiumBorder(),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("SUBMIT"),
            ),
          ),
        ]),
      ),
    );
  }
}
