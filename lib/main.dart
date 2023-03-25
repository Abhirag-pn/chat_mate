import 'package:chatmate/constants/colors.dart';
import 'package:chatmate/pages/account_page.dart';
import 'package:flutter/material.dart';

void main() {
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
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),

            backgroundColor: primary,
          )),
          primarySwatch: Palette.mainswatch,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: accent,
              ),
          textTheme: const TextTheme(
              bodySmall: TextStyle(
                  color: accent,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
              labelMedium: TextStyle(
                  color: primary,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
                 labelSmall: TextStyle(
                  color: primary,
                  decoration: TextDecoration.underline,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  ),
              displaySmall:  TextStyle(
                  color: primary,
                 
                  fontSize: 13,
                  fontFamily: 'Poppins',
             
                  ),
              titleMedium: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  )),
        ),
        home: const AccountPage());
  }
}
