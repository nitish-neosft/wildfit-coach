import 'package:intl/intl.dart';

class DateFormatter {
  static final DateFormat _defaultDateFormat = DateFormat('MMM d, y');
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _shortDateFormat = DateFormat('d/M/y');

  /// Formats date to 'Month Day, Year' (e.g., "March 15, 2024")
  static String formatDate(DateTime date) {
    return _defaultDateFormat.format(date);
  }

  /// Formats date to 'dd/mm/yyyy' (e.g., "15/3/2024")
  static String formatShortDate(DateTime date) {
    return _shortDateFormat.format(date);
  }

  /// Formats time to 24-hour format (e.g., "14:30")
  static String formatTime(DateTime time) {
    return _timeFormat.format(time);
  }

  /// Formats datetime relative to today (e.g., "Today at 14:30" or "15/3/2024 at 14:30")
  static String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'Never';

    if (dateTime.year == DateTime.now().year &&
        dateTime.month == DateTime.now().month &&
        dateTime.day == DateTime.now().day) {
      return 'Today at ${formatTime(dateTime)}';
    }

    return '${formatShortDate(dateTime)} at ${formatTime(dateTime)}';
  }

  /// Gets the full month name (e.g., "March" for month 3)
  static String getMonthName(int month) {
    if (month < 1 || month > 12) {
      throw ArgumentError('Month must be between 1 and 12');
    }
    return DateFormat('MMMM').format(DateTime(2024, month));
  }

  /// Formats a date range (e.g., "March 15 - April 20, 2024")
  static String formatDateRange(DateTime start, DateTime end) {
    if (start.year == end.year) {
      if (start.month == end.month) {
        return '${DateFormat('MMMM d').format(start)} - ${DateFormat('d, y').format(end)}';
      }
      return '${DateFormat('MMMM d').format(start)} - ${DateFormat('MMMM d, y').format(end)}';
    }
    return '${_defaultDateFormat.format(start)} - ${_defaultDateFormat.format(end)}';
  }

  /// Returns a relative time string (e.g., "2 hours ago", "5 days ago")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }
}
