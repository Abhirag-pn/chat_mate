import 'package:chatmate/models/usermodel.dart';

class GroupModel {
  String? groupid;
  String? groupname;
  String? groupinfo;
  String? groupicon;
  List<UserModel>? participants;
  List<UserModel>? admins;
  DateTime? createdon;

  GroupModel(
      {required this.groupid,
      required this.groupname,
      required this.groupicon,
      required this.groupinfo,
      required this.participants,
      required this.admins,
      required this.createdon});

GroupModel.fromMap(Map<String,dynamic>map){
  groupid=map["groupid"];
  groupname=map["groupname"];
  groupicon=map["groupicon"];
  groupinfo=map["groupinfo"];
  participants=map["participants"];
  admins=map["admins"];
  createdon=map["createdon"];
}


Map<String,dynamic>toMap(){
  return {
"groupid":groupid,
"groupname":groupname,
"groupinfo":groupinfo,
"groupicon":groupicon,
"participants":participants,
"admins":admins,
"createdon":createdon

  };
}


}
