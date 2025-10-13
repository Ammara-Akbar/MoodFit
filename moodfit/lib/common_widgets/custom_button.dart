
import 'package:flutter/material.dart';
import 'package:moodfit/utils/colors.dart';

class CustomButton extends StatelessWidget {
 final VoidCallback ontap;
 final String text;
  const CustomButton({
    super.key, required this.ontap, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        child:  Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

