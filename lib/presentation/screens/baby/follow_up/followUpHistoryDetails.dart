import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FollowUpHistoryDetails extends StatelessWidget {
  final Map followUp;
  const FollowUpHistoryDetails({super.key, required this.followUp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المتابعة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Follow-up Date
            Text(
              'تاريخ المتابعة: ${_formatDate(followUp['follow_up_date'])}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Milestone Lists
            _buildMilestoneList(
                'المهارات الحركية', followUp['motormilestones']),
            _buildMilestoneList(
                'مهارات التغذية', followUp['feedingmilestones']),
            _buildMilestoneList(
                'مهارات التواصل', followUp['communicationmilestones']),
            _buildMilestoneList(
                'المهارات الحسية', followUp['sensorymilestones']),

            const SizedBox(height: 10),

            // Health Status
            Row(
              children: [
                const Text('الحالة الصحية:', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Icon(
                  followUp['healthy'] ? Icons.check_circle : Icons.cancel,
                  color: followUp['healthy'] ? Colors.green : Colors.red,
                  size: 24,
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Notes (if available)
            if (followUp['notes'] != null &&
                followUp['notes'].toString().isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'ملاحظات: ${followUp['notes']}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper function to format date
  String _formatDate(String date) {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
  }

  // Helper function to build milestone lists
  Widget _buildMilestoneList(String title, List<dynamic>? milestones) {
    if (milestones == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...milestones.asMap().entries.map((entry) {
          bool isCompleted = entry.value;
          return ListTile(
            leading: Icon(
              isCompleted ? Icons.check_circle : Icons.cancel,
              color: isCompleted ? Colors.green : Colors.red,
            ),
            title: Text(
                'المعيار ${entry.key + 1}'), // Replace with actual names if needed
          );
        }),
      ],
    );
  }
}
