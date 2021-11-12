import 'package:auto_fix/Constants/cust_colors.dart';
<<<<<<< HEAD:lib/UI/SideBar/Profile/EditProfile/edit_profile_screen.dart
import 'package:auto_fix/UI/SideBar/Profile/EditProfile/edit_profile_bloc.dart';
=======
import 'package:auto_fix/UI/Customer/Home/Profile/EditProfile/edit_profile_bloc.dart';
>>>>>>> a24f82096464da68f60291951771eb4f46989a15:lib/UI/Customer/Home/Profile/EditProfile/edit_profile_screen.dart
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditProfileScreenState();
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final EditProfileBloc _editProfileBloc = EditProfileBloc();
  @override
  void initState() {
    super.initState();
    _editProfileBloc.postEditProfileRequest();
    _getEditProfile();
  }

  @override
  void dispose() {
    super.dispose();
    _editProfileBloc.dispose();
  }

  _getEditProfile() async {
    _editProfileBloc.postEditProfile.listen((value) {
      if (value.status == "error") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
