import 'package:flutter/material.dart';

class BoardOverlay extends StatelessWidget {
  const BoardOverlay({
    super.key,
    required this.date,
    required this.location,
    required this.workType,
    required this.description,
  });

  final String date;
  final String location;
  final String workType;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildInfoRow(Icons.calendar_today, '날짜', date),
          if (location.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildInfoRow(Icons.location_on, '위치', location),
          ],
          if (workType.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildInfoRow(Icons.work, '공종', workType),
          ],
          if (description.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildInfoRow(Icons.description, '설명', description),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
