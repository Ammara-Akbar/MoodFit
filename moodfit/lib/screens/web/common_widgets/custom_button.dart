
import 'package:flutter/material.dart';
import 'package:moodfit/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? ontap;
  final Color color;
  const CustomButton({
    super.key, required this.title, this.ontap,  this.color=AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            
            borderRadius: BorderRadius.circular(80),
          ),
        ),
       onPressed:ontap,
        child:  Text(
         title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16, color: Colors.white),
        ),
      ),
    );


  }
}
