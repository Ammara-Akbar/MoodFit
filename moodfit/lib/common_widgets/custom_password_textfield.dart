import 'package:flutter/material.dart';
import 'package:skinapp/utils/colors.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;
  // final String prefixIcon;
  final IconData suffixIcon;
  final Color borderColor;
  final String? Function(String?)? validator;

  const CustomPasswordField({
    Key? key,
    this.controller,
    this.label = "Password",
    this.hint = "Your Password",
    // this.prefixIcon = MyImages.keyIcon,
    this.suffixIcon = Icons.remove_red_eye_outlined,
    this.borderColor = AppColors.greyBorder,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),

        FormField<String>(
          validator: widget.validator,
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
                    controller: widget.controller,
                    obscureText: _obscureText,
                    onChanged: (val) {
                      state.didChange(val);
                    },
                    cursorColor: AppColors.primaryBlueColor,
                    decoration: InputDecoration(
                      // prefixIcon: Padding(
                      //   padding: const EdgeInsets.all(14.0),
                      //   child: Image.asset(widget.prefixIcon, height: 5),
                      // ),
                      suffixIcon: IconButton(
                        onPressed: _togglePasswordVisibility,
                        icon: _obscureText
                            ? const Icon(Icons.visibility_off_outlined,size: 20,
                                color: AppColors.greyText)
                            : Icon(widget.suffixIcon,
                                color: AppColors.greyText,size: 20),
                      ),
                      hintText: widget.hint,
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
                        borderSide: BorderSide(color: widget.borderColor),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(color: AppColors.primaryBlueColor),
                      ),
                    ),
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
