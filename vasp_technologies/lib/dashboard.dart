import 'package:flutter/material.dart';

import 'main.dart';

void main() {
  runApp(const TeacherDashboardApp());
}

class TeacherDashboardApp extends StatelessWidget {
  const TeacherDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFB01C33),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB01C33),
          primary: const Color(0xFFB01C33),
        ),
      ),
      home: LoginScreen(),
    );
  }
}

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  final PageController _notificationController = PageController(initialPage: 0);
  int _currentNotificationIndex = 0;

  final List<NotificationItem> _notifications = [
    NotificationItem(
      message: 'You have received a new announcement',
      date: '23rd May, 2024',
      tag: 'New',
      tagColor: Colors.blue,
    ),
    NotificationItem(
      message: 'Staff meeting scheduled for tomorrow',
      date: '24th May, 2024',
      tag: 'Important',
      tagColor: Colors.orange,
    ),
    NotificationItem(
      message: 'Submit student marks by Friday',
      date: '25th May, 2024',
      tag: 'Urgent',
      tagColor: Colors.red,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Add listener to update current page index
    _notificationController.addListener(() {
      if (_notificationController.page?.round() != _currentNotificationIndex) {
        setState(() {
          _currentNotificationIndex = _notificationController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _notificationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFFB01C33)),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xFFB01C33)),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 2.0,
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              // Header section
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    // App logo or school logo
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.school,
                        size: 42,
                        color: const Color(0xFFB01C33),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Teacher Dashboard',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB01C33),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                  ],
                ),
              ),

              // Menu items scrollable section
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildDrawerCategory('Main Menu'),
                    _buildDrawerItem(context, Icons.access_time_filled, 'Attendance'),
                    _buildDrawerItem(context, Icons.exit_to_app, 'Leave'),
                    _buildDrawerItem(context, Icons.people, 'Compensation'),

                    _buildDrawerCategory('Academics'),
                    _buildDrawerItem(context, Icons.schedule, 'Timetable'),
                    _buildDrawerItem(context, Icons.assignment, 'Task'),
                    _buildDrawerItem(context, Icons.star, 'Marks Entry'),
                    _buildDrawerItem(context, Icons.description, 'Syllabus'),

                    _buildDrawerCategory('Resources'),
                    _buildDrawerItem(context, Icons.book, 'Library'),
                    _buildDrawerItem(context, Icons.contacts, 'Contact Info'),
                  ],
                ),
              ),

              // Profile and logout section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile at bottom-left
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFB01C33),
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.asset(
                                'assets/images/teacher.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'D. K Sharma',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Text(
                                  'Economics Teacher',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Logout at bottom-right
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.logout,
                            color: Color(0xFFB01C33),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            children: [
              // Profile Card
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 100), // Reduced space at top to account for overlapping image
                        // Name and Designation section
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 100, bottom: 12), // Added padding at top for image overlap
                          decoration: const BoxDecoration(
                            color: Color(0xFFB01C33),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: const Column(
                            children: [
                              Text(
                                'D. K Sharma',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Teacher (Economics)',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Profile Image - positioned to overlap
                    Positioned(
                      top: 10,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFB01C33),
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/teacher.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Notification Carousel
              Container(
                height: 80,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: PageView.builder(
                  controller: _notificationController,
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _notifications[index].message,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  _notifications[index].date,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: _notifications[index].tagColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _notifications[index].tag,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Dots indicator
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < _notifications.length; i++)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == _currentNotificationIndex ? const Color(0xFFB01C33) : Colors.grey[300],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),

              // Grid Menu
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  shrinkWrap: true,
                  children: [
                    _buildMenuItem(icon: Icons.access_time_filled, title: 'Attendance', color: const Color(0xFFB01C33)),
                    _buildMenuItem(icon: Icons.exit_to_app, title: 'Leave', color: const Color(0xFFB01C33)),
                    _buildMenuItem(icon: Icons.people, title: 'Compensation', color: const Color(0xFFB01C33)),
                    _buildMenuItem(icon: Icons.schedule, title: 'Timetable', color: const Color(0xFFB01C33)),
                    _buildMenuItem(icon: Icons.assignment, title: 'Task', color: const Color(0xFFB01C33)),
                    _buildMenuItem(icon: Icons.star, title: 'Marks Entry', color: const Color(0xFFB01C33)),
                    _buildMenuItem(icon: Icons.description, title: 'Syllabus', color: const Color(0xFFB01C33)),
                    _buildMenuItem(icon: Icons.book, title: 'Library', color: const Color(0xFFB01C33)),
                    _buildMenuItem(icon: Icons.contacts, title: 'Contact Info', color: const Color(0xFFB01C33)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawerCategory(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      dense: true,
      horizontalTitleGap: 12,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFFB01C33),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        // Close the drawer
        Navigator.pop(context);
        // Add your navigation logic here
      },
    );
  }

  Widget _buildMenuItem({required IconData icon, required String title, required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: color),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class NotificationItem {
  final String message;
  final String date;
  final String tag;
  final Color tagColor;

  NotificationItem({
    required this.message,
    required this.date,
    required this.tag,
    required this.tagColor,
  });
}