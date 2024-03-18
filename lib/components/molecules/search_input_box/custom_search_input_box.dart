import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/constants/app_strings.dart';
import 'package:kapil_sahu_cred/constants/spacing_constants.dart';

class CustomSearchInputBox extends StatefulWidget {
  const CustomSearchInputBox({
    super.key,
    this.textInputType = TextInputType.text,
    this.controller,
    this.hintText,
    this.enabled = true,
    this.showSuffixIcon = true,
    this.debounceDuration,
    this.onSubmitted,
    this.labelText,
    this.inputFormatters,
    this.validator,
    this.autovalidateMode,
    this.fillColor,
    this.filled,
  });

  final TextInputType textInputType;
  final TextEditingController? controller;
  final String? hintText;
  final bool enabled;
  final bool showSuffixIcon;
  final Duration? debounceDuration;
  final Function(String)? onSubmitted;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final Color? fillColor;
  final bool? filled;

  @override
  State<CustomSearchInputBox> createState() => _CustomSearchInputBoxState();
}

class _CustomSearchInputBoxState extends State<CustomSearchInputBox> {
  @override
  void initState() {
    super.initState();
    // add listener when suffic icon needs to be displayed
    widget.showSuffixIcon
        ? widget.controller!.addListener(() {
            if (mounted) {
              setState(() {});
            }
          })
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.textInputType,
      autofocus: false,
      style: const TextStyle(color: AppColors.white),
      cursorColor: AppColors.white,
      decoration: InputDecoration(
        hintText: AppStrings.searchEvents,
        hintStyle: const TextStyle(color: AppColors.offWhiteColor),
        border: const OutlineInputBorder(),
        suffixIcon: widget.controller!.text.length > 0
            ? Container(
                transform:
                    Matrix4.translationValues(kSpacingZero, -2, kSpacingZero),
                child: IconButton(
                  onPressed: () {
                    widget.controller!.clear();
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    size: 20,
                  ),
                ),
              )
            : null,
        suffixIconColor: AppColors.white,
      ),
      onSubmitted: widget.onSubmitted,
      enabled: true,
    );
  }

  @override
  void dispose() {
    widget.showSuffixIcon ? widget.controller!.removeListener(() {}) : null;
    super.dispose();
  }
}
