import 'package:chatmate/ui/screens/homepage.dart';
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
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> groupsdata) {
        if (groupsdata.connectionState == ConnectionState.active||groupsdata.connectionState== ConnectionState.done) {
          if (groupsdata.hasData ) {
            return ListView.builder(
              
                itemCount: groupsdata.data!.size,
                itemBuilder: (context, index) {
                  return const ListTile(
                    title: Text(
                      "Hey",
                      style: 
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
