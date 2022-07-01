import 'package:flutter/material.dart';

class ProfileDataProvider extends ChangeNotifier {
   String? id;
   String? name="";
   String? profileImage;

  //ProfileDataProvider(this.id, this.name, this.profileImage);
  String get getName{
    return name!;
  }

  String get getId{
    return id!;
  }

  String get getProfile{
    return profileImage!;
  }

  void setProfile(String id, String name, String profile) {
    this.id = id;
    this.name = name;
    this.profileImage = profile;
    notifyListeners();
  }

}
