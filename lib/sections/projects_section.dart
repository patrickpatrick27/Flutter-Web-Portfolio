import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Text("Recent Projects", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: const [
              ProjectCard(
                title: "Payroll Tracker", 
                description: "An intelligent application for efficient employee payroll management."
              ),
              ProjectCard(
                title: "Nap Locator", 
                description: "A collaborative geolocation app designed to find resting spots."
              ),
              ProjectCard(
                title: "Private Photo App", 
                description: "A secure media sharing platform utilizing Firebase Storage."
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;

  const ProjectCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(description, style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () { /* Add Link Logic */ }, 
              child: const Text("View Details")
            ),
          ],
        ),
      ),
    );
  }
}