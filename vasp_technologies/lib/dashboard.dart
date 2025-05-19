import 'package:flutter/material.dart';

import 'main.dart';

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
    // Get screen size for responsiveness
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    // Calculate responsive sizes
    final double profileImageSize = screenWidth * 0.4;
    final double menuItemPadding = screenWidth * 0.02;
    final double menuIconSize = screenWidth * 0.06;

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
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.03,
                    horizontal: screenWidth * 0.04
                ),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    // App logo or school logo
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.school,
                        size: screenWidth * 0.1,
                        color: const Color(0xFFB01C33),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const Text(
                      'Teacher Dashboard',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB01C33),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
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
                padding: EdgeInsets.all(screenWidth * 0.04),
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
                            width: screenWidth * 0.12,
                            height: screenWidth * 0.12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFB01C33),
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(screenWidth * 0.06),
                              child: Image.asset(
                                'assets/images/teacher.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
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
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          child: Icon(
                            Icons.logout,
                            color: const Color(0xFFB01C33),
                            size: screenWidth * 0.06,
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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                children: [
                  // Profile Card
                  Container(
                    margin: EdgeInsets.all(screenWidth * 0.04),
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
                            SizedBox(height: screenHeight * 0.1), // Reduced space at top for overlapping image
                            // Name and Designation section
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  top: profileImageSize * 0.58,
                                  bottom: screenHeight * 0.015
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0xFFB01C33),
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'D. K Sharma',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.045,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.005),
                                  Text(
                                    'Teacher (Economics)',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.035,
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
                          top: screenHeight * 0.01,
                          child: Container(
                            width: profileImageSize,
                            height: profileImageSize,
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
                    height: screenHeight * 0.1,
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: PageView.builder(
                      controller: _notificationController,
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                              vertical: screenHeight * 0.01
                          ),
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
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.035,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      _notifications[index].date,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.03,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.02,
                                    vertical: screenHeight * 0.003
                                ),
                                decoration: BoxDecoration(
                                  color: _notifications[index].tagColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  _notifications[index].tag,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.03,
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
                  SizedBox(height: screenHeight * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < _notifications.length; i++)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                          width: screenWidth * 0.02,
                          height: screenWidth * 0.02,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i == _currentNotificationIndex ? const Color(0xFFB01C33) : Colors.grey[300],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Grid Menu - adaptive grid based on screen size
                  GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _getGridCrossAxisCount(screenWidth),
                      mainAxisSpacing: screenHeight * 0.02,
                      crossAxisSpacing: screenWidth * 0.04,
                      childAspectRatio: _getChildAspectRatio(screenWidth),
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      // List of menu items
                      final List<Map<String, dynamic>> menuItems = [
                        {'icon': Icons.access_time_filled, 'title': 'Attendance'},
                        {'icon': Icons.exit_to_app, 'title': 'Leave'},
                        {'icon': Icons.people, 'title': 'Compensation'},
                        {'icon': Icons.schedule, 'title': 'Timetable'},
                        {'icon': Icons.assignment, 'title': 'Task'},
                        {'icon': Icons.star, 'title': 'Marks Entry'},
                        {'icon': Icons.description, 'title': 'Syllabus'},
                        {'icon': Icons.book, 'title': 'Library'},
                        {'icon': Icons.contacts, 'title': 'Contact Info'},
                      ];

                      return _buildMenuItem(
                          icon: menuItems[index]['icon'],
                          title: menuItems[index]['title'],
                          color: const Color(0xFFB01C33),
                          iconSize: menuIconSize,
                          padding: menuItemPadding
                      );
                    },
                  ),
                  // Add padding at the bottom for better scrolling experience
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper method to determine grid cross axis count based on screen width
  int _getGridCrossAxisCount(double width) {
    if (width > 600) {
      return 4; // Tablets and larger devices
    } else if (width > 400) {
      return 3; // Medium-sized phones
    } else {
      return 2; // Small phones
    }
  }

  // Helper method to determine child aspect ratio based on screen width
  double _getChildAspectRatio(double width) {
    if (width > 600) {
      return 1.2; // Tablets and larger devices
    } else if (width > 400) {
      return 1.0; // Medium-sized phones
    } else {
      return 0.9; // Small phones
    }
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

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color color,
    required double iconSize,
    required double padding
  }) {
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
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: color),
            ),
            child: Icon(
              icon,
              color: color,
              size: iconSize,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: iconSize * 0.5,
              color: color,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
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