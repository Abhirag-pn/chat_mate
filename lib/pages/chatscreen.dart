import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
    static const routeName="chatscreen";
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        FirebaseAuth.instance.signOut();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Logged out!")));
      }),
      backgroundColor: Colors.white,
      body: const Center(
        child: Text("This is chat screen"),
      ),
    );
  }
}
