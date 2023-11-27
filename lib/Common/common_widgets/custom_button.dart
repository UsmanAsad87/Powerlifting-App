import 'package:flutter/material.dart';

import '../../utils/styles_manager.dart';
import 'loading.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,
    required this.onPressed,
    required this.buttonText,
    this.isLoading = false,
    this.backColor,
    this.textColor,
    this.buttonWidth,
    this.buttonHeight,
    this.fontSize,
    this.padding,
    this.borderRadius,
  }) : super(key: key);

  final Function()? onPressed;
  final String buttonText;
  final bool isLoading;
  final Color? backColor;
  final Color? textColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? fontSize;
  final double? padding;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('customButton'),
      height: buttonHeight ?? 45,
      margin: EdgeInsets.symmetric(vertical: padding ?? 10),
      child: RawMaterialButton(
        elevation: 2,
        fillColor:
            backColor ?? Theme.of(context).colorScheme.secondaryContainer,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 50),
        ),
        child: SizedBox(
          // padding: EdgeInsets.symmetric(vertical: 10.h),
          width: buttonWidth ?? double.infinity,
          height: buttonHeight ?? 45,
          child: Center(
              child: isLoading
                  ? LoadingWidget(
                      color: Theme.of(context).colorScheme.onPrimary)
                  : Text(
                      buttonText,
                      style: getSemiBoldStyle(
                          color: textColor ??
                              Theme.of(context).colorScheme.onPrimary,
                          fontSize: fontSize ?? 14),
                    )),
        ),
      ),
    );
  }
}
