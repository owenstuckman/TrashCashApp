import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_points.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  static const Color vtMaroon = Color(0xFF861F41);
  static const Color vtOrange = Color(0xFFE87722);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards'),
      ),
      body: Consumer<UserPoints>(
        builder: (context, userPoints, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Points Balance Card with VT gradient
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
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Available Rewards Header
              const Text(
                'Available Rewards',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: vtMaroon,
                ),
              ),
              const SizedBox(height: 16),

              // Reward Items
              _buildRewardItem(
                context,
                '\$5 Hokie Credit',
                '500 points',
                'Add to your Hokie Passport',
                Icons.school,
              ),
              _buildRewardItem(
                context,
                '\$10 Hokie Credit',
                '1000 points',
                'Add to your Hokie Passport',
                Icons.school,
              ),
              _buildRewardItem(
                context,
                '\$10 Target Gift Card',
                '2000 points',
                'Digital gift card delivery',
                Icons.card_giftcard,
              ),
              _buildRewardItem(
                context,
                '\$20 Target Gift Card',
                '4000 points',
                'Digital gift card delivery',
                Icons.card_giftcard,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRewardItem(BuildContext context, String title, String points, String subtitle, IconData icon) {
    // Extract numeric points value
    final pointsCost = int.parse(points.replaceAll(RegExp(r'[^0-9]'), ''));
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: vtMaroon.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: vtMaroon),
            ),
            const SizedBox(width: 16),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  points,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: vtMaroon,
                  ),
                ),
                const SizedBox(height: 4),
                Consumer<UserPoints>(
                  builder: (context, userPoints, child) {
                    return ElevatedButton(
                      onPressed: userPoints.points >= pointsCost ? () {
                        // Show confirmation dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Redemption'),
                              content: Text('Redeem $title for $points?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Deduct points
                                    userPoints.deductPoints(pointsCost);
                                    
                                    // Add to activity history
                                    userPoints.addActivity(
                                      ActivityItem(
                                        title: 'Redeemed $title',
                                        points: '-$points',
                                        timestamp: DateTime.now(),
                                        icon: Icons.redeem,
                                      ),
                                    );
                                    
                                    Navigator.pop(context);
                                    
                                    // Show success message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Successfully redeemed $title'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  },
                                  child: const Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        );
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: vtMaroon,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(60, 36),
                      ),
                      child: const Text('Redeem'),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
