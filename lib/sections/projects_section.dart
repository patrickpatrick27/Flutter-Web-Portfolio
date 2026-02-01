import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          const Text("Recent Projects",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          
          // Responsive Switch
          ResponsiveLayout(
            mobile: _buildProjectList(isMobile: true),
            desktop: _buildProjectList(isMobile: false),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectList({required bool isMobile}) {
    return Wrap(
      spacing: 30,
      runSpacing: 30,
      alignment: WrapAlignment.center,
      children: const [
        ProjectCard(
            title: "Payroll Tracker",
            description: "An intelligent application for efficient employee payroll management."),
        ProjectCard(
            title: "Nap Locator",
            description: "A collaborative geolocation app designed to find resting spots."),
        ProjectCard(
            title: "Private Photo App",
            description: "A secure media sharing platform utilizing Firebase Storage."),
      ],
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;

  const ProjectCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    // Check width again here to size the individual card
    bool isMobile = ResponsiveLayout.isMobile(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        // On Mobile: take 90% of screen width. On Desktop: Fixed 350px.
        width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 350,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.code, color: Colors.blue),
            ),
            const SizedBox(height: 16),
            Text(title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(description,
                style: TextStyle(color: Colors.grey[700], height: 1.5)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("View Details"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}