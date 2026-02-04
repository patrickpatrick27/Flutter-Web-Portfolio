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
      "tech": ["Flutter", "OpenStreetMap", "Google Sheets API", "Geolocation"],
      "problem": "Field technicians were struggling to locate specific Network Access Points using only raw coordinates listed in static spreadsheets. Without a visual reference, identifying the correct box location among thousands of entries was slow, confusing, and error-prone.",
      "solution": "I migrated over 3,000+ data points from legacy files into a live Google Sheets database. I then built a Flutter app that plots these points onto OpenStreetMap. This allows technicians to visually see the NAP locations relative to their real-time GPS position, rather than just reading abstract numbers.",
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
      "desc": "Automated student logging via facial recognition (Offline Capable).",
      "url": "https://github.com/patrickpatrick27/CPEN135-Student-Attendance",
      // NOTE: Keeping image null ensures the black background & white toga icon
      "image": null, 
      "type": "Academic Project",
      "tech": ["Python", "Flask", "ESP32-CAM", "OpenCV", "Flutter"],
      "problem": "Most smart attendance systems require a stable internet connection to function. However, at CvSU, Wi-Fi availability in classrooms is inconsistent or non-existent, rendering cloud-based solutions useless.",
      "solution": "We engineered a completely offline system. The ESP32-CAM connects directly to a local server (laptop) via a dedicated hotspot. The system processes facial recognition and logs attendance locally using Python and Flask, requiring zero internet connectivity to function.",
    },
    {
      "title": "Pay Tracker",
      "desc": "Workforce management tool for automated payroll processing.",
      "url": "https://github.com/patrickpatrick27/payout_app",
      "image": "assets/images/pay_tracker.png",
      "type": "Personal Project",
      "tech": ["Flutter", "Google Drive API", "Cloud Sync", "Dart"],
      "problem": "I used to track my part-time job hours manually in my phone's notes app. It was tedious to log time-ins and time-outs every day, calculation errors were common, and I was constantly scared of losing all my data if my phone crashed.",
      "solution": "I developed a dedicated tracker that makes logging hours instant. Instead of relying on local storage, the app performs a cloud backup directly to Google Drive. This ensures my pay calculations are automated and my data is secure, even if I switch devices.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // If it's the first load, delay the animations so the header finishes first.
    // If it's a tab switch, make the delay minimal (50ms) for snappy response.
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
                        // Logic: If image is null -> Black Background
                        color: project['image'] == null ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                        image: project['image'] != null
                            ? DecorationImage(image: AssetImage(project['image']), fit: BoxFit.cover)
                            : null,
                      ),
                      // Logic: If image is null -> White School Icon (Toga)
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