import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool loading;

  const CustomButton({super.key, required this.title, required this.onTap, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 56.h,
        margin: EdgeInsets.symmetric(vertical: 16.r),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.blue),
        child: Center(
            child: loading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(title, style: const TextStyle(color: Colors.white))),
      ),
    );
  }
}
