import 'package:flutter/material.dart';

class ProfileDataProvider extends ChangeNotifier {
  late String id;
  late String name;
  late String profileImage;

  //ProfileDataProvider(this.id, this.name, this.profileImage);
  String get getName{
    return name;
  }

  String get getId{
    return name;
  }

  String get getProfile{
    return name;
  }

  void setProfile(String id, String name, String profile) {
    this.id = id;
    this.name = name;
    this.profileImage = profile;
    notifyListeners();
  }

}
