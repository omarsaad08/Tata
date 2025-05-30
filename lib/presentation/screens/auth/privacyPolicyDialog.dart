import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;

class PrivacyPolicyDialog extends StatelessWidget {
  final String markdownData;

  const PrivacyPolicyDialog({
    super.key,
    required this.markdownData,
  });

  // Alternative constructor to load from assets
  factory PrivacyPolicyDialog.fromAsset({Key? key, required String assetPath}) {
    return PrivacyPolicyDialog(
      key: key,
      markdownData: '', // Will be loaded in future builder
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.privacy_tip, color: Colors.white),
                  const SizedBox(width: 12),
                  Text(
                    'سياسة الخصوصية',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Markdown(
                data: markdownData,
                padding: const EdgeInsets.all(16),
                selectable: true,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
              ),
            ),

            // Close button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إغلاق'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
