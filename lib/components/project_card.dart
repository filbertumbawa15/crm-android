import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Test",
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 5),
                Text("Wed, 29 Jan 2025 - Fri, 31 Jan 2025",
                    style: TextStyle(
                        fontFamily: 'Lato', fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
                value: 0.0,
                backgroundColor: Colors.grey[300],
                color: Colors.purple),
            const SizedBox(height: 10),
            Row(
              children: List.generate(
                  3,
                  (index) => const Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage('assets/profile.jpg')),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
