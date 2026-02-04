import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive_animation.dart';

class ProjectDetailScreen extends StatefulWidget {
  final Map<String, dynamic> project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final bool scrolledDown = _scrollController.offset > 20;
    
    if (scrolledDown != _isScrolled) {
      setState(() {
        _isScrolled = scrolledDown;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(widget.project['url']);
    if (!await launchUrl(uri)) throw Exception('Could not launch ${widget.project['url']}');
  }

  @override
  Widget build(BuildContext context) {
    // 1. Logic to check if this is the "No Image" project (Student Attendance)
    final bool hasImage = widget.project['image'] != null;

    final backgroundColor = _isScrolled ? Colors.grey[900] : Colors.white;
    final textColor = _isScrolled ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: Colors.white,
      
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 18, 
            color: textColor, 
            fontFamily: 'GoogleSans' 
          ),
          child: Text(widget.project['title']),
        ),
        
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent, 
        
        flexibleSpace: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: backgroundColor,
        ),

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),

        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 24, right: 24, bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. HEADER IMAGE & ICON
                  Center(
                    child: Hero(
                      tag: widget.project['title'], 
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          // FIX: Force Black background if no image
                          color: hasImage ? Colors.white : Colors.black,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
                          image: hasImage
                              ? DecorationImage(image: AssetImage(widget.project['image']), fit: BoxFit.cover)
                              : null,
                        ),
                        // FIX: Force White Icon if no image
                        child: !hasImage
                            ? const Icon(Icons.school, size: 50, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 2. TITLE & TAG
                  Center(child: Text(widget.project['title'], style: AppTheme.headerStyle.copyWith(fontSize: 32))),
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(widget.project['type'], style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 3. THE "STORY" SECTIONS
                  _buildSection("💡 The Problem", widget.project['problem'] ?? "No description available."),
                  _buildSection("🛠️ How I Built It", widget.project['solution'] ?? "No description available."),
                  
                  const SizedBox(height: 20),
                  
                  // 4. TECH STACK CHIPS
                  const Text("Technologies Used", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: (widget.project['tech'] as List<String>).map((tech) => Chip(
                      label: Text(tech),
                      backgroundColor: Colors.grey[100],
                      side: BorderSide.none, 
                    )).toList(),
                  ),

                  const SizedBox(height: 40),

                  // 5. GITHUB BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: _launchUrl,
                      icon: const Icon(Icons.code),
                      label: const Text("View Source Code on GitHub", style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 5,
                        shadowColor: AppTheme.primaryColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 10),
          Text(content, style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black54)),
        ],
      ),
    );
  }
}