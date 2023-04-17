import 'package:chatmate/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
    static const routeName="groups";
  const GroupsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushNamed(Homepage.routeName);
      }),
      appBar: AppBar(title: const Text("Groups"),centerTitle: true,),
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("groups").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      snapshot.data!.docs[index]["name"],
                      style: const 
                      TextStyle(color: Colors.red),
                    ),
                  );
                });
          } else {
            return const Text(
              "No groups found",
              style: TextStyle(color: Colors.black),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}

Future<QuerySnapshot> getSnapshot() async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("group").get();
  return snapshot;
}
