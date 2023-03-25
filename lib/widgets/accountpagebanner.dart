import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';

class CustomBanner extends StatelessWidget {
  final String title,subtitle;
  const CustomBanner({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    var scrnsize=MediaQuery.of(context).size.width+MediaQuery.of(context).size.height;
    return Stack(alignment: Alignment.bottomRight, children: [
          Container(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 10,
                top: MediaQuery.of(context).size.height / 15),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            decoration: const BoxDecoration(color: primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            
              
              children:  [
                Text(
                  title,
                  style: TextStyle(fontSize: scrnsize/25, color: Colors.white,fontFamily: 'MuseoModerno',),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Text(
                    subtitle,
                    style:TextStyle(fontSize: scrnsize/75, color: Colors.white,fontFamily: 'Poppins',height: 0.2),
                  ),
                )
              ],
            ),
          ),
          SvgPicture.asset(
            "assets/image/chatp.svg",
            height: scrnsize/5,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SvgPicture.asset(
              "assets/image/circ.svg",
              height: scrnsize/8,
            ),
          )
        ]);
  }
}