import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/responsive_animation.dart';
import '../theme/app_theme.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  final List<Map<String, dynamic>> _projects = const [
    {
      "title": "NAP Finder",
      "desc": "A specialized tool used to track and locate Network Access Point (NAP) boxes within the company database, significantly reducing maintenance response times.",
      "url": "https://github.com/patrickpatrick27/nap_locator",
      "image": "assets/images/nap_finder.png",
      "type": "Work Application", 
    },
    {
      "title": "Kaong Fermentation Monitor",
      "desc": "An IoT-integrated application that monitors fermentation stages in real-time, ensuring optimal product quality.",
      "url": "https://github.com/patrickpatrick27/kaong_fermentation_app",
      "image": "assets/images/kaong_monitor.png",
      "type": "Thesis Project",
    },
    {
      "title": "Student Attendance Tracker",
      "desc": "A hardware-software solution utilizing ESP32-CAM and a Flask backend to automatically track and log student attendance via facial recognition.",
      "url": "https://github.com/patrickpatrick27/CPEN135-Student-Attendance",
      "image": null,
      "type": "Academic Project",
    },
    {
      "title": "Pay Tracker",
      "desc": "A workforce management tool that tracks employee time-ins/outs and syncs data directly to Google Drive for automated payroll processing.",
      "url": "https://github.com/patrickpatrick27/payout_app",
      "image": "assets/images/pay_tracker.png",
      "type": "Personal Project",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              FadeSlideTransition(
                delay: const Duration(milliseconds: 900),
                offset: const Offset(0, 0.2),
                child: const Text("Featured Projects", style: AppTheme.headerStyle),
              ),
              const SizedBox(height: 10),
              FadeSlideTransition(
                delay: const Duration(milliseconds: 1000),
                offset: const Offset(0, 0.2),
                child: const Text("Tap a project to view the code on GitHub", style: AppTheme.subHeaderStyle),
              ),
              const SizedBox(height: 40),

              // --- GRID LOGIC ---
              LayoutBuilder(
                builder: (context, constraints) {
                  // If screen width > 700px, FORCE 2 columns. Otherwise 1.
                  int crossAxisCount = constraints.maxWidth > 700 ? 2 : 1;
                  
                  // Aspect Ratio Logic: 
                  // We want a fixed height of roughly 300px.
                  // Ratio = Width / Height.
                  double itemWidth = constraints.maxWidth / crossAxisCount;
                  double desiredHeight = 320; 
                  double childAspectRatio = itemWidth / desiredHeight;

                  return GridView.builder(
                    // Critical properties to make GridView work inside a Column
                    shrinkWrap: true, 
                    physics: const NeverScrollableScrollPhysics(),
                    
                    itemCount: _projects.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, i) {
                      return FadeSlideTransition(
                        delay: Duration(milliseconds: 1100 + (i * 200)),
                        offset: const Offset(0, 0.5),
                        child: ProjectCard(
                          title: _projects[i]['title'],
                          description: _projects[i]['desc'],
                          url: _projects[i]['url'],
                          imagePath: _projects[i]['image'],
                          type: _projects[i]['type'],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String url;
  final String? imagePath;
  final String type;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.url,
    this.imagePath,
    required this.type,
    // Note: We no longer need to pass width/height manually
    // because GridView handles the sizing constraints.
  });

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw Exception('Could not launch $url');
  }

  Color _getTagColor(String type) {
    switch (type) {
      case "Work Application": return AppTheme.primaryColor;
      case "Thesis Project": return AppTheme.tempColor;
      case "Academic Project": return AppTheme.phColor;
      case "Personal Project": return AppTheme.gravityColor;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tagColor = _getTagColor(type);

    return Card(
      child: InkWell(
        onTap: _launchUrl,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: imagePath == null ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                      ],
                      image: imagePath != null
                          ? DecorationImage(
                              image: AssetImage(imagePath!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: imagePath == null
                        ? const Icon(Icons.school, color: Colors.white, size: 30)
                        : null,
                  ),
                  Icon(Icons.arrow_outward, size: 20, color: AppTheme.primaryColor)
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: tagColor.withOpacity(0.1), 
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: tagColor.withOpacity(0.3)),
                ),
                child: Text(
                  type.toUpperCase(),
                  style: TextStyle(
                    color: tagColor, 
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 12),
              
              // Title
              Text(title, 
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)
              ),
                      
              const SizedBox(height: 8),
              
              // Description
              Expanded(
                child: Text(
                  description, 
                  overflow: TextOverflow.fade,
                  style: AppTheme.subHeaderStyle.copyWith(height: 1.5, fontSize: 14)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}