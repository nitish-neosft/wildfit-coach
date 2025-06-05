import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class LanguagePickerDialog extends StatelessWidget {
  final String currentLanguage;
  final Function(String) onLanguageSelected;

  const LanguagePickerDialog({
    super.key,
    required this.currentLanguage,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final languages = [
      {'code': 'en', 'name': 'English'},
      {'code': 'es', 'name': 'Español'},
      {'code': 'fr', 'name': 'Français'},
      {'code': 'de', 'name': 'Deutsch'},
      {'code': 'it', 'name': 'Italiano'},
      {'code': 'pt', 'name': 'Português'},
    ];

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Language',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ...languages.map(
              (language) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Radio<String>(
                  value: language['code']!,
                  groupValue: currentLanguage,
                  onChanged: (value) {
                    if (value != null) {
                      onLanguageSelected(value);
                      Navigator.of(context).pop();
                    }
                  },
                ),
                title: Text(
                  language['name']!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  onLanguageSelected(language['code']!);
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: AppColors.darkGrey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
