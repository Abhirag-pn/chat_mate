import 'package:chatmate/ui/screens/loginpage.dart';
import 'package:chatmate/ui/screens/groupspage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  static const routeName = "homepage";
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
           
              return const GroupsPage();
            
          }
          return const  AccountPage();
        });
  }
}
