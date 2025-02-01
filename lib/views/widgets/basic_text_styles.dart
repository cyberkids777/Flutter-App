import 'package:dsw_52804/utils/base_colors.dart';
import 'package:flutter/material.dart';


Widget BasicSignInText(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.only(top: 21, bottom: 26),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: CustomColors.purpleColor,
      ),
    ),
  );
}
