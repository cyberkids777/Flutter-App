import 'package:dsw_52804/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BasicTextFormField extends StatefulWidget {
  final String hintText;
  final String prefixIcon;
  final bool isPasswordField;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const BasicTextFormField({
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.isPasswordField = false,
    this.validator,
    super.key,
  });

  @override
  State<BasicTextFormField> createState() => _BasicTextFormFieldState();
}

class _BasicTextFormFieldState extends State<BasicTextFormField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: !widget.isPasswordField ? _isPasswordVisible = _isPasswordVisible : !_isPasswordVisible,
        keyboardType: widget.isPasswordField
            ? TextInputType.text
            : TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: SvgPicture.asset(
            fit: BoxFit.scaleDown,
            height: 30,
            width: 30,
            widget.prefixIcon,
          ),
          suffixIcon: widget.isPasswordField
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  child: _changeSuffixIcon(_isPasswordVisible))
              : null,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 2,
              color: CustomColors.lightPurpleColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 2,
              color: CustomColors.lightPurpleColor,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
        ),
      ),
    );
  }
}

Widget? _changeSuffixIcon(bool isPasswordVisible) {
  return isPasswordVisible
      ? const Icon(Icons.visibility_off_outlined)
      : const Icon(Icons.visibility_outlined);
}
