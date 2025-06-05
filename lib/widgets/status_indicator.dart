import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

enum StatusType { success, warning, error, info, neutral }

class StatusIndicator extends StatelessWidget {
  final StatusType type;
  final String text;
  final IconData? customIcon;
  final Color? customColor;
  final double? iconSize;
  final TextStyle? textStyle;

  const StatusIndicator({
    super.key,
    required this.type,
    required this.text,
    this.customIcon,
    this.customColor,
    this.iconSize,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          customIcon ?? _getDefaultIcon(),
          color: customColor ?? _getDefaultColor(),
          size: iconSize ?? 20,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: textStyle ??
              TextStyle(
                color: customColor ?? _getDefaultColor(),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  IconData _getDefaultIcon() {
    switch (type) {
      case StatusType.success:
        return Icons.check_circle;
      case StatusType.warning:
        return Icons.warning;
      case StatusType.error:
        return Icons.error;
      case StatusType.info:
        return Icons.info;
      case StatusType.neutral:
        return Icons.circle;
    }
  }

  Color _getDefaultColor() {
    switch (type) {
      case StatusType.success:
        return AppColors.success;
      case StatusType.warning:
        return AppColors.warning;
      case StatusType.error:
        return AppColors.error;
      case StatusType.info:
        return AppColors.primary;
      case StatusType.neutral:
        return AppColors.darkGrey;
    }
  }
}

// Extension widget for membership status
class MembershipStatusIndicator extends StatelessWidget {
  final DateTime expiryDate;

  const MembershipStatusIndicator({
    super.key,
    required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    final daysLeft = expiryDate.difference(DateTime.now()).inDays;

    if (daysLeft < 0) {
      return const StatusIndicator(
        type: StatusType.error,
        text: 'Expired',
      );
    }

    if (daysLeft < 30) {
      return StatusIndicator(
        type: StatusType.warning,
        text: '$daysLeft days left',
      );
    }

    return const StatusIndicator(
      type: StatusType.success,
      text: 'Active',
    );
  }
}
