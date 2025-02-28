import 'package:flutter/material.dart';

class DashboardSmallCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const DashboardSmallCard(
      {super.key, required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 4), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.purple),
            const SizedBox(height: 8),
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Lato')),
          ],
        ),
      ),
    );
  }
}
