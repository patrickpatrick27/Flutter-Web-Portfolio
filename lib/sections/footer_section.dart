import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  Future<void> _launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      color: Colors.grey[100],
      child: Column(
        children: [
          const Text("Ready to collaborate?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            alignment: WrapAlignment.center,
            children: [
              _FooterButton(
                label: "Email Me", 
                icon: Icons.email, 
                onTap: () => _launch("mailto:davepatrickbulaso@gmail.com")
              ),
              _FooterButton(
                label: "LinkedIn", 
                icon: Icons.work, 
                onTap: () => _launch("https://www.linkedin.com/in/dave-patrick-bulaso-169b7b307/")
              ),
              _FooterButton(
                label: "GitHub", 
                icon: Icons.code, 
                onTap: () => _launch("https://github.com/patrickpatrick27")
              ),
              _FooterButton(
                label: "Resume", 
                icon: Icons.description, 
                onTap: () => _launch("https://drive.google.com/file/d/1soZfWi-rY3eBRWrRYCLrkCsIPF_z800U/view")
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 20),
          Text("Phone: +63 939 880 6317", style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 8),
          Text("© 2026 Dave Patrick Bulaso. Built with Flutter.", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }
}

class _FooterButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _FooterButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        side: const BorderSide(color: Colors.grey),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}