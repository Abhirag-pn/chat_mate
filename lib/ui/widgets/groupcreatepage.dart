import 'package:chatmate/ui/widgets/biotextfeild.dart';

import 'package:flutter/material.dart';

class GroupCreatePage extends StatelessWidget {
  const GroupCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Group"),

      ),
      body: Column(
        children: [
          // CustomTextFeild(label: "Group Name", isobs: false, onSave: (val){}),
          BioTextFeild(label: "Group Bio", validator: (val){
            return "";
          }, onSave: (val){})
        ],
      ),
    );
  }
}