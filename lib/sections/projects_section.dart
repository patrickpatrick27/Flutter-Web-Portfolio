import 'package:flutter/material.dart';
import '../screens/project_detail_screen.dart'; 
import '../widgets/responsive_layout.dart';
import '../widgets/responsive_animation.dart';
import '../theme/app_theme.dart';

class ProjectsSection extends StatelessWidget {
  final bool isFirstLoad; 

  const ProjectsSection({super.key, this.isFirstLoad = false});

  final List<Map<String, dynamic>> _projects = const [
    {
      "title": "NAP Finder",
      "desc": "A specialized tool used to track and locate Network Access Point (NAP) boxes.",
      "url": "https://github.com/patrickpatrick27/nap_locator",
      "image": "assets/images/nap_finder.png",
      "type": "Work Application",
      // UPDATED TECH: Removed Google Maps API, Added OpenStreetMap
      "tech": ["Flutter", "OpenStreetMap", "Firebase", "Geolocation"],
      // UPDATED STORY
      "problem": "Locating specific Network Access Point (NAP) boxes was a manual and inefficient process. We needed a way to search for specific Local Convergence Points (LCPs) and get precise location data without scrolling through static lists.",
      "solution": "I built a location-based app using OpenStreetMap for the internal interface. Users can search for an LCP, see its location, and either copy the coordinates or click a button to open Google Maps. The app uses the device's current GPS to plot a direct route from the user to the actual NAP box.",
    },
    {
      "title": "Kaong Fermentation Monitor",
      "desc": "An IoT-integrated application that monitors fermentation stages in real-time.",
      "url": "https://github.com/patrickpatrick27/kaong_fermentation_app",
      "image": "assets/images/kaong_monitor.png",
      "type": "Thesis Project",
      "tech": ["Flutter", "ESP32", "C++", "Firebase Realtime DB", "Sensors"],
      "problem": "Sugar palm (Kaong) vinegar production is highly sensitive to temperature and pH levels. Traditional farmers rely on guesswork, leading to inconsistent batches and spoilage.",
      "solution": "I designed an IoT system using an ESP32 microcontroller with pH and temperature sensors. This data is sent to a Flutter app where farmers can monitor the fermentation graph live. The app even sends push notifications if the temperature exceeds the safe threshold.",
    },
    {
      "title": "Student Attendance Tracker",
      "desc": "Automated student logging via facial recognition.",
      "url": "https://github.com/patrickpatrick27/CPEN135-Student-Attendance",
      "image": null,
      "type": "Academic Project",
      "tech": ["Python", "Flask", "ESP32-CAM", "OpenCV", "Flutter"],
      "problem": "Manual roll calls in large lecture halls consume 10-15 minutes of class time and are prone to 'buddy punching' (students signing in for friends).",
      "solution": "We created a hands-free system. An ESP32-CAM positioned at the door captures faces as students enter. A Flask backend processes the images using OpenCV for recognition and automatically marks them 'Present' in the database, viewable via the Flutter admin app.",
    },
    {
      "title": "Pay Tracker",
      "desc": "Workforce management tool for automated payroll processing.",
      "url": "https://github.com/patrickpatrick27/payout_app",
      "image": "assets/images/pay_tracker.png",
      "type": "Personal Project",
      "tech": ["Flutter", "Google Sheets API", "Cloud Sync", "Dart"],
      // UPDATED STORY
      "problem": "I used to track my part-time job hours manually in my phone's notes app. It was tedious to log time-ins and time-outs every day, calculation errors were common, and I was constantly scared of losing all my data if my phone crashed.",
      "solution": "I developed a dedicated tracker that makes logging hours instant. Instead of local notes, it syncs everything online to Google Sheets. Now, my total pay is calculated automatically, and I never have to worry about data loss because everything is securely backed up in the cloud.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int baseDelay = isFirstLoad ? 900 : 50;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              FadeSlideTransition(
                delay: Duration(milliseconds: baseDelay),
                offset: const Offset(0, 0.2),
                child: const Text("Featured Projects", style: AppTheme.headerStyle),
              ),
              const SizedBox(height: 10),
              FadeSlideTransition(
                delay: Duration(milliseconds: baseDelay + 100),
                offset: const Offset(0, 0.2),
                child: const Text("Tap a project to view case study", style: AppTheme.subHeaderStyle),
              ),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 700 ? 2 : 1;
                  double itemWidth = constraints.maxWidth / crossAxisCount;
                  double desiredHeight = 320; 
                  double childAspectRatio = itemWidth / desiredHeight;

                  return GridView.builder(
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
                        delay: Duration(milliseconds: (baseDelay + 200) + (i * 100)),
                        offset: const Offset(0, 0.5),
                        child: ProjectCard(
                          project: _projects[i], 
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
  final Map<String, dynamic> project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    Color getTagColor(String type) {
      switch (type) {
        case "Work Application": return AppTheme.primaryColor;
        case "Thesis Project": return AppTheme.tempColor;
        case "Academic Project": return AppTheme.phColor;
        case "Personal Project": return AppTheme.gravityColor;
        default: return Colors.grey;
      }
    }

    final tagColor = getTagColor(project['type']);

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailScreen(project: project),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero( 
                    tag: project['title'],
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: project['image'] == null ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                        image: project['image'] != null
                            ? DecorationImage(image: AssetImage(project['image']), fit: BoxFit.cover)
                            : null,
                      ),
                      child: project['image'] == null
                          ? const Icon(Icons.school, color: Colors.white, size: 30)
                          : null,
                    ),
                  ),
                  Icon(Icons.arrow_forward, size: 20, color: AppTheme.primaryColor)
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: tagColor.withOpacity(0.1), 
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: tagColor.withOpacity(0.3)),
                ),
                child: Text(
                  project['type'].toUpperCase(),
                  style: TextStyle(color: tagColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
              ),
              const SizedBox(height: 12),
              Text(project['title'], maxLines: 1, overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  project['desc'], 
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