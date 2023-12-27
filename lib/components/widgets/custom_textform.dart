import 'package:barter_it/resources/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? valid;
  final TextInputType? keyBoardType;
  final bool? password;
  final bool? readOnly;

  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.hint,
    required this.suffixIcon,
    required this.controller,
    required this.valid,
    required this.keyBoardType,
    this.password,
    this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: valid,
      keyboardType: keyBoardType,
      obscureText: password == null ? false
          : password == true ? true : false,
      decoration: InputDecoration(
        border:  OutlineInputBorder(
          borderRadius: const BorderRadius.all( Radius.circular(30)),
          borderSide: BorderSide(color: AppColors.grey, width: 1),
        ),
        focusedBorder:  const OutlineInputBorder(
          borderRadius: BorderRadius.all( Radius.circular(30)),
          borderSide:  BorderSide(color: AppColors.primary, width: 1),
        ),
        suffixIcon: Icon(suffixIcon),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        label: Text(label),
        suffixIconConstraints: BoxConstraints.tight(const Size(70, 20)),
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 14,
        ),
        // labelStyle: const TextStyle(color: AppColors.primaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      controller: controller,
      readOnly: readOnly == null ? false
          : readOnly == true ? true : false,
    );
  }
}
