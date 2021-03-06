import 'package:ari_gong_gan/http/login_crawl.dart';
import 'package:ari_gong_gan/screen/login_page.dart';
import 'package:ari_gong_gan/screen/tmp.dart';
import 'package:ari_gong_gan/widget/login_data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

const Color color = Color(0xfff9e769);

void main() {
  isLoginDataSaved() async {
    var ctrl = new LoginData();
    var assurance = await ctrl.loadLoginData();
    String saved_id = assurance["user_id"] ?? "";
    String saved_pw = assurance["user_pw"] ?? "";

    try {
      var loginCrwal = LoginCrwal(id: saved_id, pw: saved_pw);
      final getuserInfo = await loginCrwal.userInfo();
      return Tmp();
    } catch (e) {
      return LoginPage();
    }
  }

  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.allowReassignment = true;
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSans'),
      title: '아리공간',
      home: AnimatedSplashScreen.withScreenFunction(
        splash: Image.asset('assets/images/title.png'),
        splashIconSize: 170,
        screenFunction: isLoginDataSaved,
        duration: 100,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: color,
        // duration: 3000,
      ),
    ),
  );
}
