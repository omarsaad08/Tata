import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

class FollowUpResult extends StatefulWidget {
  final bool healthy;
  final double motorScore;
  final double sensoryScore;
  final double feedingScore;
  final double communicationScore;
  final String reportDetails;

  const FollowUpResult({
    super.key,
    required this.healthy,
    required this.motorScore,
    required this.sensoryScore,
    required this.feedingScore,
    required this.communicationScore,
    required this.reportDetails,
  });

  @override
  State<FollowUpResult> createState() => _FollowUpResultState();
}

class _FollowUpResultState extends State<FollowUpResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("نتيجة المتابعة الدورية", style: TextStyle(color: clr(0))),
        centerTitle: true,
        backgroundColor: clr(1),
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
              color: widget.healthy ? Colors.green[50] : Colors.orange[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      widget.healthy
                          ? Icons.celebration
                          : Icons.medical_services,
                      size: 48,
                      color: widget.healthy ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.healthy
                          ? "طفلك ينمو بشكل سليم"
                          : "يحتاج إلى متابعة",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: widget.healthy ? Colors.green : Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.healthy
                          ? "جميع المجالات ضمن المعدل الطبيعي"
                          : "هناك بعض المجالات تحتاج إلى انتباه",
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
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
                  widget.motorScore,
                  Colors.blueAccent,
                ),
                _buildProgressCard(
                  "👂 النمو الحسي",
                  widget.sensoryScore,
                  Colors.purpleAccent,
                ),
                _buildProgressCard(
                  "🍼 التغذية",
                  widget.feedingScore,
                  Colors.amber,
                ),
                _buildProgressCard(
                  "🗣 التواصل",
                  widget.communicationScore,
                  Colors.teal,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Details Card
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
                      "التفاصيل:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.reportDetails,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  if (!widget.healthy) ...[
                    Expanded(
                      child: mainElevatedButton("احجز مع دكتور", () {
                        Navigator.pushNamed(context, "offlineDoctorBooking");
                      }),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: mainElevatedButton("الرئيسية", () {
                      Navigator.pushNamed(context, "babyHome");
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(String title, double score, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8), // Reduced padding from 12 to 8
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Added this line
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14, // Reduced from 16 to 14
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Added for better text wrapping
              maxLines: 2, // Prevent text overflow
            ),
            const SizedBox(height: 4), // Reduced from 8 to 4
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 60, // Reduced from 70 to 60
                  height: 60, // Reduced from 70 to 60
                  child: CircularProgressIndicator(
                    value: score / 100,
                    strokeWidth: 6, // Reduced from 8 to 6
                    backgroundColor: color.withOpacity(0.2),
                    color: color,
                  ),
                ),
                Text(
                  "${score.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: 16, // Reduced from 18 to 16
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4), // Reduced from 8 to 4
            Text(
              _getScoreStatus(score),
              style: TextStyle(
                fontSize: 12, // Reduced from 14 to 12
                color: _getScoreColor(score),
              ),
            ),
          ],
        ),
      ),
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
