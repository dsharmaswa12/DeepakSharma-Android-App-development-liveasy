import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color.dart';

class CustomRadio extends StatelessWidget {
  final bool isSelected;

  const CustomRadio({Key? key, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: ShapeDecoration(
            shape: OvalBorder(
              side: BorderSide(width: 1, color: Colors.black),
            ),
          ),
        ),
        if (isSelected)
          Positioned(
            left: 6,
            top: 6,
            right: 6,
            bottom: 6,
            child: Container(
              decoration: ShapeDecoration(
                color: AppColors.primaryColor,
                shape: OvalBorder(),
              ),
            ),
          ),
      ],
    );
  }
}
class OtpInput extends StatelessWidget {
  final RxString field;

  OtpInput({required this.field});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.e0xFF93D2F3,
      ),
      child: Text(
        field.value,
        style: TextStyle(fontSize: 24),
      ),
    ));
  }
}
