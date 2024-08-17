import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobs_creator/add_jobs_page.dart';
import 'package:jobs_creator/navigator.dart';
import 'package:jobs_creator/signin_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> jobTitle = [];
  List<String> jobDetails = [];

  getData() async {
    FirebaseFirestore.instance.collection("jobs").get().then((value) {
      value.docs.forEach((element) {
        print("${element['job_title']}");
        setState(() {});
        jobTitle.add(element['job_title']);
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest jobs"),
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoNextPage(context, AddJobsPage());
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Email  : ${FirebaseAuth.instance.currentUser?.email}",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 30),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("jobs").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                          child: Icon(Icons.cancel),
                        ),
                        onDismissed: (direction) {
                          FirebaseFirestore.instance
                              .collection("jobs")
                              .doc(snapshot.data!.docs[index].id)
                              .delete();
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(
                                "${snapshot.data!.docs[index]['job_title']}"),
                            subtitle: Text(
                                "${snapshot.data!.docs[index]['details']}"),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
