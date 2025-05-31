import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tata/data/periodicFollowUpServices.dart';
import 'package:tata/presentation/components/theme.dart';

class FollowUpHistoryDetails extends StatelessWidget {
  final Map followUp;
  const FollowUpHistoryDetails({super.key, required this.followUp});

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد من حذف هذه المتابعة؟'),
          actions: <Widget>[
            TextButton(
              child: const Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'حذف',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                try {
                  await PeriodicFollowUpServices.deleteFollowUp(followUp['id']);
                  if (context.mounted) {
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.of(context).pop(
                        true); // Go back with result true to indicate deletion
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم حذف المتابعة بنجاح'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.of(context).pop(); // Close dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('حدث خطأ أثناء الحذف: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate scores for each category
    final motorScore = _calculateScore(followUp['motormilestones']);
    final sensoryScore = _calculateScore(followUp['sensorymilestones']);
    final feedingScore = _calculateScore(followUp['feedingmilestones']);
    final communicationScore =
        _calculateScore(followUp['communicationmilestones']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المتابعة'),
        backgroundColor: clr(1),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _showDeleteConfirmationDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: followUp['healthy'] ? Colors.green[50] : Colors.orange[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      followUp['healthy']
                          ? Icons.celebration
                          : Icons.medical_services,
                      size: 48,
                      color: followUp['healthy'] ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      followUp['healthy'] ? "النمو سليم" : "يحتاج إلى متابعة",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color:
                            followUp['healthy'] ? Colors.green : Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'تاريخ المتابعة: ${_formatDate(followUp['follow_up_date'])}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Progress Cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                _buildProgressCard(
                  "🧠 النمو الحركي",
                  motorScore,
                  Colors.blueAccent,
                ),
                _buildProgressCard(
                  "👂 النمو الحسي",
                  sensoryScore,
                  Colors.purpleAccent,
                ),
                _buildProgressCard(
                  "🍼 التغذية",
                  feedingScore,
                  Colors.amber,
                ),
                _buildProgressCard(
                  "🗣 التواصل",
                  communicationScore,
                  Colors.teal,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Milestone Details Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "تفاصيل المعالم التنموية:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildMilestoneSection(
                      "المهارات الحركية",
                      followUp['motormilestones'],
                      Colors.blueAccent,
                    ),
                    _buildMilestoneSection(
                      "مهارات التغذية",
                      followUp['feedingmilestones'],
                      Colors.amber,
                    ),
                    _buildMilestoneSection(
                      "مهارات التواصل",
                      followUp['communicationmilestones'],
                      Colors.teal,
                    ),
                    _buildMilestoneSection(
                      "المهارات الحسية",
                      followUp['sensorymilestones'],
                      Colors.purpleAccent,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Notes Section
            if (followUp['notes'] != null &&
                followUp['notes'].toString().isNotEmpty)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "ملاحظات إضافية:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        followUp['notes'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Helper function to format date
  String _formatDate(String date) {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
  }

  // Helper function to calculate score percentage
  double _calculateScore(List<dynamic>? milestones) {
    if (milestones == null || milestones.isEmpty) return 0;
    final completed = milestones.where((m) => m == true).length;
    return (completed / milestones.length) * 100;
  }

  // Build progress card widget
  Widget _buildProgressCard(String title, double score, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const SizedBox(height: 4),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    value: score / 100,
                    strokeWidth: 6,
                    backgroundColor: color.withOpacity(0.2),
                    color: color,
                  ),
                ),
                Text(
                  "${score.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              _getScoreStatus(score),
              style: TextStyle(
                fontSize: 12,
                color: _getScoreColor(score),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build milestone section widget
  Widget _buildMilestoneSection(
      String title, List<dynamic>? milestones, Color color) {
    if (milestones == null || milestones.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        ...milestones.asMap().entries.map((entry) {
          bool isCompleted = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(
                  isCompleted ? Icons.check_circle : Icons.cancel,
                  color: isCompleted ? Colors.green : Colors.red,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'المعيار ${entry.key + 1}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  String _getScoreStatus(double score) {
    if (score >= 80) return "ممتاز";
    if (score >= 60) return "جيد";
    return "يحتاج متابعة";
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.blue;
    return Colors.orange;
  }
}
