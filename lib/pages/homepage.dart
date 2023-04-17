import 'package:chatmate/pages/account_page.dart';
import 'package:chatmate/pages/chatscreen.dart';
import 'package:chatmate/pages/complete_profile.dart';
import 'package:chatmate/pages/groupspage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
            if (snapshot.data!.displayName == null) {
              return const CompleteProfile();
            } else {
              return const ChatScreen();
            }
          }
          return const AccountPage();
        });
  }
}
