import 'package:flutter/material.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [headerWidgetColor, SecondHeaderWidgetColor],
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.only(top: 100),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Just for You", fontSize: 18),
              CustomText(
                text: "Exclusive Deals Handpicked for You",
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 20),
              JustForYouCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class JustForYouCard extends StatelessWidget {
  const JustForYouCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(.2),
            offset: const Offset(0, 10),
            blurRadius: 8,
            spreadRadius: 5,
          ),
        ],
      ),
    );
  }
}
