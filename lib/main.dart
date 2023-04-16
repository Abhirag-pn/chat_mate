import 'package:chatmate/constants/colors.dart';
import 'package:chatmate/pages/forgotpassword.dart';
import 'package:chatmate/pages/groupspage.dart';
import 'package:chatmate/pages/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chatmate',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: primary,centerTitle: true ,titleTextStyle: TextStyle(fontFamily: "MUseoModerno",fontSize: 20)),
          snackBarTheme: const SnackBarThemeData(
              behavior: SnackBarBehavior.floating,
              insetPadding: EdgeInsets.all(8),
              contentTextStyle: TextStyle(fontFamily: 'Poppins')),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: primary,
          )),
          primarySwatch: Palette.mainswatch,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: accent,
              ),
          textTheme: const TextTheme(
              bodySmall: TextStyle(
                  color: accent,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
              labelMedium: TextStyle(
                  color: primary,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
              labelSmall: TextStyle(
                color: primary,
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
              displaySmall: TextStyle(
                color: primary,
                fontSize: 13,
                fontFamily: 'Poppins',
              ),
              titleMedium: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
          ),
        ),
        home: const Homepage());
  }
}
