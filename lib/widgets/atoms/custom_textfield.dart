import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isObscure;
  final String? hintText;

  const CustomTextField(
      {super.key, required this.controller, required this.focusNode, this.isObscure = false, this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscure,
      focusNode: focusNode,
      maxLines: 1,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(16.h, 12.h, 16.h, 12.h),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
          borderSide: BorderSide(width: 2.r, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: const BorderSide(color: Colors.blueGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: const BorderSide(color: Colors.blueGrey),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
          borderSide: BorderSide(width: 2.r, color: Colors.transparent),
        ),
      ),
    );
  }
}
