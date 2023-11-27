import 'package:flutter/material.dart';
import '../../utils/styles_manager.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextInputType? inputType;
  final bool obscure;
  final IconData? icon;
  final String? Function(String?)? validatorFn;
  final Widget? leadingIcon;
  final Widget? tailingIcon;
  final String? tailingIconPath;
  final double? texFieldHeight;
  final double? borderRadius;
  final double? verticalPadding;
  final double? verticalMargin;
  final String label;
  final Color? fillColor;
  final int? maxLines;
  final bool showLabel;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputType,
    this.leadingIcon,
    this.obscure = false,
    this.validatorFn,
    this.icon,
    this.tailingIcon,
    this.texFieldHeight,
    required this.label,
    this.showLabel = true,
    this.tailingIconPath,
    this.fillColor,
    this.maxLines,
    this.borderRadius,
    this.verticalPadding,
    this.verticalMargin, required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin ?? 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0, bottom: 5),
            child: Row(
              children: [
                Text(
                  label,
                  style: getSemiBoldStyle(
                      fontSize: 13,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          TextFormField(
            validator: validatorFn,
            obscureText: obscure,
            controller: controller,
            keyboardType: inputType,
            maxLines: maxLines ?? 1,
            style: getRegularStyle(
                fontSize: 12,
                color: Colors.black),
            decoration: InputDecoration(
              fillColor:
                  fillColor ?? Colors.white,
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: verticalPadding ?? 0.0),
              errorStyle: getRegularStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.error),
              suffixIcon: tailingIcon,
              hintText: hintText,
              hintStyle: getRegularStyle(
                  fontSize: 12,
                  color: Colors.black45),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100),
                borderSide:
                    const BorderSide(color: Colors.red, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100),
                borderSide:
                    const BorderSide(color: Colors.red, width: 1.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100),
                borderSide:
                    const BorderSide(color: Colors.red, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100),
                borderSide:
                    const BorderSide(color: Colors.red, width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100),
                borderSide:
                    const BorderSide(color: Colors.red, width: 1.0),
              ),
            ),
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
