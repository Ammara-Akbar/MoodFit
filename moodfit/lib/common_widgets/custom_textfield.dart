import 'package:flutter/material.dart';
import 'package:skinapp/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;
  // final String prefixIcon;
  final Color borderColor;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    this.controller,  
    this.label = "Email",
    this.hint = "Your Email Address",
    // this.prefixIcon = MyImages.mailIcon,
    this.borderColor = AppColors.borderColor
         ,
    this.validator,
    this.keyboardType = TextInputType.emailAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),

        // Container for styling
        FormField<String>(
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: controller,
                    onChanged: (val) {
                      state.didChange(val);
                    },
                    keyboardType: keyboardType,
                    cursorColor: AppColors.primaryBlueColor,
                    decoration: InputDecoration(
                      // prefixIcon: Padding(
                      //   padding: const EdgeInsets.all(14.0),
                      //   child: Image.asset(prefixIcon, height: 5),
                      // ),
                      hintText: hint,
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: AppColors.greyText),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(color: AppColors.primaryBlueColor),
                      ),
                    ),
                    // validator: validator,
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 2, left: 4),
                    child: Text(
                      state.errorText ?? '',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
