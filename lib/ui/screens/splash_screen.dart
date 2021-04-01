import 'package:antonx/core/constant/colors.dart';
import 'package:antonx/core/constant/text_style.dart';
import 'package:antonx/core/services/auth_services.dart';
import 'package:antonx/ui/screens/dashboard/dashboard_screen.dart';
import 'package:antonx/ui/screens/registration_auth/login/login_screen.dart';
import 'package:flutter/material.dart';

import '../locator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authService = locator<AuthService>();

  ///
  /// splash screen Time
  ///
  navigateToNextScreen() async {
    await Future.delayed(Duration(milliseconds: 500));
    if (_authService.isLogin && _authService.appUser == null) {
      navigateToNextScreen();
    } else if (_authService.isLogin) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
                (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    navigateToNextScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Text("Techylem Blog App",
        style: headingTextStyle,
        ),
      ),
    );
  }
}
