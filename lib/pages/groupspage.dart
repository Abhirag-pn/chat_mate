import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                });
          } else {
            return const Text(
              "data",
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
