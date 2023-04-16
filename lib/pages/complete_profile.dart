import 'dart:io';
import 'dart:math';

import 'package:chatmate/widgets/biotextfeild.dart';
import 'package:chatmate/widgets/custombutton.dart';
import 'package:chatmate/widgets/customtxtfeild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  String? usermail = FirebaseAuth.instance.currentUser!.email;
  late String username;
  File? profilepic;
  late String bio;
  final _formkey = GlobalKey<FormState>();

  Future<void> pickImage() async {}

  Future<void> finishProfile() async {
    final formstate = _formkey.currentState!.validate();
    log(12);
    FocusScope.of(context).unfocus();
    if (formstate) {
      _formkey.currentState!.save();
      if (usermail != null && profilepic != null) {
      TaskSnapshot picsnap=  await FirebaseStorage.instance
            .ref()
            .child("profilepictures")
            .child(FirebaseAuth.instance.currentUser!.uid)
            .putFile(profilepic!);

            String downloadurl=await picsnap.ref.getDownloadURL();
        await FirebaseFirestore.instance.collection("users").add({
          "email": usermail,
          "username": username,
          "bio": bio,
          "imgurl":downloadurl
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complete Profile"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            InkWell(
              onTap: () async {
                XFile? pickedimage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedimage != null) {
                  File convertedfile = File(pickedimage.path);
                  setState(() {
                    profilepic = convertedfile;
                  });
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Error")));
                  }
                }
              },
              child: Stack(alignment: Alignment.bottomRight, children: [
                CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage:
                        (profilepic != null) ? FileImage(profilepic!) : null,
                    radius: MediaQuery.of(context).size.height / 15,
                    child: (profilepic == null)
                        ? Icon(
                            Icons.person,
                            size: MediaQuery.of(context).size.height / 10,
                            color: Theme.of(context).primaryColor,
                          )
                        : null),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  radius: 15,
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Profile photo",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            CustomTextFeild(
                readonly: true,
                deafult: FirebaseAuth.instance.currentUser!.email,
                label: "Email",
                isobs: false,
                onSave: (val) {}),
            CustomTextFeild(
                label: "Username",
                isobs: false,
                validator: (val) {
                  val = val!.trim();
                  if (val.isEmpty) {
                    return "Enter A Valid Username";
                  } else {
                    return null;
                  }
                },
                onSave: (val) {
                  if (val != null) {
                    username = val;
                  }
                }),
            BioTextFeild(
                label: "Bio",
                validator: (val) {
                  val = val!.trim();
                  if (val.isEmpty) {
                    return "Enter a bio";
                  } else {
                    return null;
                  }
                },
                onSave: (val) {
                  if (val != null) {
                    bio = val;
                  }
                }),
            CustomButton(label: "Finish", ontap: finishProfile)
          ]),
        ),
      ),
    );
  }
}
