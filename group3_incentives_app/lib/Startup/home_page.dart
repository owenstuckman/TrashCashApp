import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_points.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Consumer<UserPoints>(
        builder: (context, userPoints, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Profile Header with VT Colors
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF861F41), Color(0xFFE87722)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://brand.vt.edu/content/brand_vt_edu/en/licensing/university-trademarks/athletic-trademark/_jcr_content/content/textimage/image.transform/m-medium/image.jpg',
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Hokie Student',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'hokie@vt.edu',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                // Stats Section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatCard('Total Points', '${userPoints.points}'),
                      _buildStatCard('Level', userPoints.points >= 1000 ? 'Gold' : 'Silver'),
                      _buildStatCard('Activities', '${userPoints.activities.length}'),
                    ],
                  ),
                ),

                // Recent Activity Section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent Activity',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF861F41),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Show actual activities from state
                      ...userPoints.activities.take(3).map((activity) =>
                        _buildActivityItem(
                          activity.title,
                          activity.points,
                          _formatTimestamp(activity.timestamp),
                        ),
                      ).toList(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF861F41),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String points, String time) {
    final bool isPositive = points.startsWith('+');
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(time),
        trailing: Text(
          points,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isPositive ? Colors.green : const Color(0xFF861F41),
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final difference = DateTime.now().difference(timestamp);
    if (difference.inHours < 24) {
      return difference.inHours == 0 
          ? 'Just now'
          : '${difference.inHours} hours ago';
    } else if (difference.inDays < 2) {
      return 'Yesterday';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}



