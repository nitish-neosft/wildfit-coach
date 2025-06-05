import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class TestResultRow extends StatelessWidget {
  final String test;
  final bool passed;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final double? iconSize;

  const TestResultRow({
    super.key,
    required this.test,
    required this.passed,
    this.onTap,
    this.padding,
    this.textStyle,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            test,
            style: textStyle ??
                const TextStyle(
                  fontSize: 16,
                  color: AppColors.white,
                ),
          ),
        ),
        Icon(
          passed ? Icons.check_circle : Icons.cancel,
          color: passed ? AppColors.success : AppColors.error,
          size: iconSize ?? 24,
        ),
      ],
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 8.0),
          child: row,
        ),
      );
    }

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8.0),
      child: row,
    );
  }
}

class TestResultsList extends StatelessWidget {
  final Map<String, bool> testResults;
  final void Function(String, bool)? onTestTap;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final double? iconSize;

  const TestResultsList({
    super.key,
    required this.testResults,
    this.onTestTap,
    this.padding,
    this.textStyle,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: testResults.entries.map((entry) {
        return TestResultRow(
          test: entry.key,
          passed: entry.value,
          onTap: onTestTap != null
              ? () => onTestTap!(entry.key, entry.value)
              : null,
          padding: padding,
          textStyle: textStyle,
          iconSize: iconSize,
        );
      }).toList(),
    );
  }
}

class TestResultsSummary extends StatelessWidget {
  final Map<String, bool> testResults;
  final TextStyle? summaryStyle;

  const TestResultsSummary({
    super.key,
    required this.testResults,
    this.summaryStyle,
  });

  @override
  Widget build(BuildContext context) {
    final passedTests = testResults.values.where((passed) => passed).length;
    final totalTests = testResults.length;
    final passRate = (passedTests / totalTests * 100).round();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$passedTests/$totalTests tests passed ($passRate%)',
          style: summaryStyle ??
              TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: passRate >= 70
                    ? AppColors.success
                    : passRate >= 50
                        ? AppColors.warning
                        : AppColors.error,
              ),
        ),
      ],
    );
  }
}
