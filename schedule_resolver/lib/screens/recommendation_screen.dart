import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Siguraduhin na tama ang path na ito
import '../services/ai_schedule_service.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FIX: Nilagyan ng <AiScheduleService> para ma-recognize ang import
    final aiService = Provider.of<AiScheduleService>(context);

    // Ngayon, alam na ng Dart na ang .currentAnalysis ay galing sa AiScheduleService
    final analysis = aiService.currentAnalysis;

    if (analysis == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('AI Schedule Recommendation')),
        body: const Center(child: Text('No AI Analysis Data Available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Schedule Recommendation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSection(context, 'Detected Conflicts', analysis.conflicts, Colors.red.shade100, Icons.warning_amber_rounded),
            const SizedBox(height: 16),
            _buildSection(context, 'Ranked Task', analysis.rankedTasks, Colors.blue.shade100, Icons.format_list_numbered),
            const SizedBox(height: 16),
            _buildSection(context, 'Recommended Schedule', analysis.recommendedSchedule, Colors.green.shade100, Icons.calendar_today),
            const SizedBox(height: 16),
            _buildSection(context, 'Explanation', analysis.explanation, Colors.orange.shade100, Icons.lightbulb_outline),
          ],
        ),
      ),
    );
  }

  // Ginawang private method sa loob ng class para mas malinis
  Widget _buildSection(BuildContext context, String title, String content, Color bgColor, IconData icon) {
    return Card(
      color: bgColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 28),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(),
            Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}