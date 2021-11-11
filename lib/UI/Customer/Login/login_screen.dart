import 'package:auto_fix/UI/Customer/Login/Signin/signin_screen.dart';
import 'package:auto_fix/UI/Customer/Login/Signup/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: NestedScrollView(
        body: TabBarView(
            controller: _tabController,
            children: const [SigninScreen(), SignupScreen()]),
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }
}
