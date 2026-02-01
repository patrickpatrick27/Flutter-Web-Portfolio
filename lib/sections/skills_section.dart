import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../theme/app_theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Technical Expertise", style: AppTheme.headerStyle),
              const SizedBox(height: 30),
              
              // Container for the whole skills area to separate it from the white bg
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.grey[50], // Very light grey to stand out from white
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[200]!), // Subtle border
                ),
                child: ResponsiveLayout(
                  mobile: Column(
                    children: [
                      _SkillGroup(title: "Mobile Development", skills: const [
                        "Flutter & Dart", "Firebase Integration", "REST APIs", "State Management (Bloc/Provider)"
                      ]),
                      const SizedBox(height: 30),
                      _SkillGroup(title: "IoT & Hardware", skills: const [
                        "ESP32 / Arduino", "Sensors & Actuators", "C++ for Embedded", "MQTT Protocol"
                      ]),
                      const SizedBox(height: 30),
                      _SkillGroup(title: "Tools & Workflow", skills: const [
                        "Git & GitHub", "VS Code", "Figma", "Agile/Scrum"
                      ]),
                    ],
                  ),
                  desktop: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: _SkillGroup(title: "Mobile Development", skills: const [
                        "Flutter & Dart", "Firebase Integration", "REST APIs", "State Management"
                      ])),
                      Expanded(child: _SkillGroup(title: "IoT & Hardware", skills: const [
                        "ESP32 / Arduino", "Sensors & Actuators", "C++ for Embedded", "MQTT Protocol"
                      ])),
                      Expanded(child: _SkillGroup(title: "Tools & Workflow", skills: const [
                        "Git & GitHub", "VS Code", "Figma", "Agile/Scrum"
                      ])),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillGroup extends StatelessWidget {
  final String title;
  final List<String> skills;

  const _SkillGroup({required this.title, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
        const SizedBox(height: 15),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: skills.map((skill) => Chip(
            label: Text(skill),
            backgroundColor: Colors.white,
            elevation: 2,
            shadowColor: Colors.black12,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          )).toList(),
        ),
      ],
    );
  }
}