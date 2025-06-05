import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/constants/colors.dart';
import '../core/utils/form_validators.dart';

class MeasurementInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? unit;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  const MeasurementInputField({
    super.key,
    required this.label,
    required this.controller,
    this.unit,
    this.validator,
    this.onChanged,
    this.textInputAction,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: textInputAction,
      style: const TextStyle(color: AppColors.white),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        labelText: label,
        suffixText: unit,
        suffixStyle: const TextStyle(color: AppColors.darkGrey),
        labelStyle: const TextStyle(color: AppColors.darkGrey),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkDivider),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.error),
        ),
      ),
      validator:
          validator ?? (value) => FormValidators.measurement(value, label),
      onChanged: onChanged,
    );
  }
}
