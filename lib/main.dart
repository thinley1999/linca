import 'package:flutter/material.dart';
import 'package:linca/list/press_business.dart';
import 'package:linca/list/press_civil_servant.dart';
import 'package:linca/list/press_monastic.dart';
import 'package:linca/list/press_student.dart';
import 'package:linca/scanner/image_scanner.dart';
import 'package:linca/scanner/main_scanner.dart';
import 'package:linca/list/scanned_list.dart';
import 'package:linca/user_cards/user_business.dart';
import 'package:linca/user_cards/user_civil_servant.dart';
import 'package:linca/user_cards/user_college_student.dart';
import 'package:linca/user_cards/user_monastic.dart';
import 'package:linca/user_qr/business_qr.dart';
import 'package:linca/user_qr/civil_servant_qr.dart';
import 'package:linca/user_qr/college_student_qr.dart';
import 'package:linca/user_qr/monastic_qr.dart';
import 'package:linca/widget/sign_in.dart';
import 'package:linca/pages/home_page.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          ),
      initialRoute: '/sign_in',
      routes: {
        '/sign_in' : (context) => LoginPage(),
        '/home' : (context) => HomePage(),
        '/business' : (context) => UserBusiness(),
        '/civil_servant' : (context) => UserCivilServant(),
        '/monastic' : (context) => UserMonastic(),
        '/college_student' : (context) => UserCollegeStudent(),
        '/scanner' : (context) => QRScanPage(),
        '/scanned_list' : (context) => ScannedList(),
        '/business_qr' : (context) => BusinessQr(),
        '/civil_servant_qr' : (context) => CivilServantQr(),
        '/monastic_qr' : (context) => MonasticQr(),
        '/college_student_qr' : (context) => CollegeStudentQr(),
        '/press_business': (context) => PressBusiness(),
        '/press_civil_servant': (context) => PressCivilServant(),
        '/press_monastic' : (context) => PressMonastic(),
        '/press_student' : (context) => PressStudent(),
        '/image_scanner': (context) => ImageScanner(),
      },
      theme: Theme.of(context).copyWith(platform: TargetPlatform.android),
      debugShowCheckedModeBanner: false,
    );
  }
}