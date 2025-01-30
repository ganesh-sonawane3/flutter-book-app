import 'package:flutter/material.dart';
import 'package:myapp/resources/colors.dart';

class AppButton extends StatefulWidget {
  final onPressed, text, fontSize;
  final Color? bgColor, borderColor, textColor;
  final double? borderRadius;
  final Size? size;
  final bool loading;

  const AppButton({
    super.key,
    this.onPressed,
    this.text,
    this.bgColor,
    this.borderColor,
    this.textColor,
    this.borderRadius,
    this.size,
    this.fontSize,
    this.loading = false,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        side: WidgetStateProperty.resolveWith<BorderSide>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed))
              return BorderSide(
                color: widget.borderColor ?? AppColors.colorPrimary,
              );
            else if (states.contains(WidgetState.disabled))
              return const BorderSide(
                color: AppColors.disabled,
              );
            return BorderSide(
              color: widget.borderColor ?? AppColors.colorSecondary,
            );
          },
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? 12,
            ),
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed))
              return widget.bgColor ?? AppColors.colorPrimary;
            else if (states.contains(WidgetState.disabled))
              return AppColors.disabled;
            return widget.bgColor ?? AppColors.colorPrimary;
          },
        ),
        minimumSize: WidgetStateProperty.all(widget.size ?? const Size(1, 58)),
      ),
      onPressed: widget.loading ? null : widget.onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.loading)
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: widget.textColor ?? AppColors.white,
              ),
            ),
          if (widget.loading)
            const SizedBox(
              width: 14,
            ),
          Text(
            widget.text,
            style: TextStyle(
              color: widget.textColor ?? AppColors.white,
              fontSize: widget.fontSize ?? 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Open Sans'
            ),
          ),
        ],
      ),
    );
  }
}