import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_points.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  static const Color vtMaroon = Color(0xFF861F41);
  static const Color vtOrange = Color(0xFFE87722);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity History'),
      ),
      body: Consumer<UserPoints>(
        builder: (context, userPoints, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Points Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [vtMaroon, vtOrange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Available Points',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${userPoints.points}',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              const Text(
                'Recent Activities',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: vtMaroon,
                ),
              ),
              const SizedBox(height: 16),
              
              // Activity items
              ...userPoints.activities.map((activity) => 
                _buildActivityItem(
                  activity.title,
                  activity.points,
                  activity.timestamp.toString(),
                  activity.icon,
                ),
              ).toList(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActivityItem(String itemName, String points, String time, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: vtMaroon.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: vtMaroon),
        ),
        title: Text(itemName),
        subtitle: Text(time),
        trailing: Text(
          points,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: vtMaroon,
          ),
        ),
      ),
    );
  }
}

class _StatisticWidget extends StatelessWidget {
  const _StatisticWidget({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
