import 'package:flutter/material.dart';

const Color kLightColor = Color(0xff00ACEA);
const TextStyle labelStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
PreferredSize buildAppBar(
    BuildContext context, String title, String icon, bool hasBackButton) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(150),
    child: Center(
      child: Row(
        children: [
          const Spacer(flex: 2),
          hasBackButton
              ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 30, color: kLightColor),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'رجوع',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          const Spacer(flex: 40),
          Container(
            width: 230,
            height: 100,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: kLightColor, width: 2)),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$title  ',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(icon),
                  )
                ],
              ),
            ),
          ),
          const Spacer(flex: 50),
        ],
      ),
    ),
  );
}
