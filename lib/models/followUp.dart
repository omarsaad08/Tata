import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class FollowUp {
  late List<Map<String, dynamic>> motorMilestones;
  late List<Map<String, dynamic>> feedingMilestones;
  late List<Map<String, dynamic>> communicationMilestones;
  late List<Map<String, dynamic>> sensoryMilestones;
  List motorValues = [];
  List feedingValues = [];
  List communicationValues = [];
  List sensoryValues = [];
  int motorCounter = 0;
  int feedingCounter = 0;
  int communicationCounter = 0;
  int sensoryCounter = 0;
  bool healthy = true;
  int counter = 0;
  int age = 0;

  // New scoring properties
  double motorScore = 0;
  double sensoryScore = 0;
  double feedingScore = 0;
  double communicationScore = 0;

  // Private constructor
  FollowUp._(this.age);

  // Factory constructor to create instance
  static Future<FollowUp> create(int age) async {
    final followUp = FollowUp._(age);
    await followUp.setup(age);
    return followUp;
  }

  Future<void> setup(int age) async {
    try {
      // Load the JSON file
      final String jsonString =
          await rootBundle.loadString('lib/data/milestones.json');
      final Map<String, dynamic> milestonesData = json.decode(jsonString);

      // Convert age to string to match JSON keys
      final String ageKey = age.toString();

      if (milestonesData.containsKey(ageKey)) {
        final Map<String, dynamic> ageData = milestonesData[ageKey];

        motorMilestones =
            List<Map<String, dynamic>>.from(ageData['motorMilestones'] ?? []);
        sensoryMilestones =
            List<Map<String, dynamic>>.from(ageData['sensoryMilestones'] ?? []);
        communicationMilestones = List<Map<String, dynamic>>.from(
            ageData['communicationMilestones'] ?? []);
        feedingMilestones =
            List<Map<String, dynamic>>.from(ageData['feedingMilestones'] ?? []);
      } else {
        // Initialize empty lists if age not found
        motorMilestones = [];
        sensoryMilestones = [];
        communicationMilestones = [];
        feedingMilestones = [];
      }
    } catch (e) {
      print('Error loading milestones: $e');
      // Initialize empty lists in case of error
      motorMilestones = [];
      sensoryMilestones = [];
      communicationMilestones = [];
      feedingMilestones = [];
    }
  }

  List generateValues() {
    motorValues = [];
    feedingValues = [];
    communicationValues = [];
    sensoryValues = [];
    motorCounter = 0;
    feedingCounter = 0;
    communicationCounter = 0;
    sensoryCounter = 0;
    for (var milestone in motorMilestones) {
      motorValues.add(milestone['isChecked']);
      milestone['isChecked'] ? null : motorCounter++;
    }
    for (var milestone in feedingMilestones) {
      feedingValues.add(milestone['isChecked']);
      milestone['isChecked'] ? null : feedingCounter++;
    }
    for (var milestone in communicationMilestones) {
      communicationValues.add(milestone['isChecked']);
      milestone['isChecked'] ? null : communicationCounter++;
    }
    for (var milestone in sensoryMilestones) {
      sensoryValues.add(milestone['isChecked']);
      milestone['isChecked'] ? null : sensoryCounter++;
    }
    // Calculate scores for each category
    motorScore = motorMilestones.isEmpty
        ? 0
        : (motorValues.where((v) => v == true).length /
                motorMilestones.length) *
            100;
    sensoryScore = sensoryMilestones.isEmpty
        ? 0
        : (sensoryValues.where((v) => v == true).length /
                sensoryMilestones.length) *
            100;
    feedingScore = feedingMilestones.isEmpty
        ? 0
        : (feedingValues.where((v) => v == true).length /
                feedingMilestones.length) *
            100;
    communicationScore = communicationMilestones.isEmpty
        ? 0
        : (communicationValues.where((v) => v == true).length /
                communicationMilestones.length) *
            100;
    print("age: $age");
    if (age >= 18) {
      if (motorCounter > 2 || communicationCounter > 1 || sensoryCounter > 1) {
        healthy = false;
      }
    } else {
      if (motorCounter > 2 ||
          feedingCounter > 1 ||
          communicationCounter > 1 ||
          sensoryCounter > 1) {
        healthy = false;
      }
    }
    return [motorValues, feedingValues, communicationValues, sensoryValues];
  }

  String generateReport() {
    generateValues(); // Ensure scores are calculated

    String report = "تقرير الطفل\n\n";
    report += "🧠 النمو الحركي: ${motorScore.toStringAsFixed(0)}%\n";
    report += "👂 النمو الحسي: ${sensoryScore.toStringAsFixed(0)}%\n";
    report += "🍼 التغذية: ${feedingScore.toStringAsFixed(0)}%\n";
    report += "🗣 التواصل: ${communicationScore.toStringAsFixed(0)}%\n\n";

    // Add warnings for weak areas
    if (motorScore < 60) report += "⚠ يحتاج إلى متابعة الحركات.\n";
    if (sensoryScore < 60) report += "⚠ يحتاج إلى متابعة النمو الحسي.\n";
    if (feedingScore < 60) report += "⚠ مشاكل محتملة في التغذية.\n";
    if (communicationScore < 60) report += "⚠ يحتاج إلى متابعة التواصل.\n";

    // Add overall health status
    report += "\nالحالة العامة: ${healthy ? "سليم" : "يحتاج إلى متابعة"}";

    return report;
  }

  double generateScore() {
    for (var val in motorValues) {
      val ? counter++ : null;
    }
    for (var val in communicationValues) {
      val ? counter++ : null;
    }
    for (var val in sensoryValues) {
      val ? counter++ : null;
    }
    for (var val in feedingValues) {
      val ? counter++ : null;
    }
    return counter /
        (motorValues.length +
            communicationValues.length +
            sensoryValues.length +
            feedingValues.length);
  }
}
