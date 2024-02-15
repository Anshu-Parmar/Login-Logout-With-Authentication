import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_initial/screens/auth_page/auth_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp( const MyApp());
  });
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Login-Logout",
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      // ResponsiveLayout(
      //   mobileScaffold: MobileLoginScreen(),
      //   desktopScaffold: DesktopLoginScreen(),
      // ),
    );
  }
}
