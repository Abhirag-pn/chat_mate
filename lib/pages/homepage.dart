import 'package:chatmate/pages/account_page.dart';
import 'package:chatmate/pages/chatscreen.dart';
import 'package:chatmate/pages/complete_profile.dart';
import 'package:chatmate/pages/groupspage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (ctx,snapshot){
      if(snapshot.hasData){
        return const CompleteProfile();
      } 
      return const AccountPage();
    });
  }
}