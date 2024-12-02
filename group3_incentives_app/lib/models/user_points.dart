import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserPoints extends ChangeNotifier {
  int _points = 1234;  // Starting points
  List<ActivityItem> _activities = [];

  int get points => _points;
  List<ActivityItem> get activities => _activities;

  void deductPoints(int amount) {
    if (_points >= amount) {
      _points -= amount;
      notifyListeners();
    }
  }

  void addActivity(ActivityItem activity) {
    _activities.insert(0, activity);  // Add to beginning of list
    notifyListeners();
  }
}

class ActivityItem {
  final String title;
  final String points;
  final DateTime timestamp;
  final IconData icon;

  ActivityItem({
    required this.title,
    required this.points,
    required this.timestamp,
    required this.icon,
  });
} 