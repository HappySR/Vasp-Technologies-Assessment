import 'package:flutter/material.dart';
import 'package:vasp_technologies/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Screen',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _employeeIdSelected = true;
  final Color _primaryColor = Color(0xFFB01B2C);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Upper half - Image with Welcome Text
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.358), // Adjust this value as needed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        "Sign in to Continue",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: screenWidth * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Lower half - Login Form
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        color: _primaryColor,
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Login Options
                    Row(
                      children: [
                        Expanded(
                          child: _buildLoginOption(
                            context,
                            "Mobile Number",
                            !_employeeIdSelected,
                            screenHeight,
                                () => setState(() => _employeeIdSelected = false),
                          ),
                        ),
                        Text(
                          "OR",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: screenHeight * 0.015,
                          ),
                        ),
                        Expanded(
                          child: _buildLoginOption(
                            context,
                            "Employee ID",
                            _employeeIdSelected,
                            screenHeight,
                                () => setState(() => _employeeIdSelected = true),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Input Field
                    Container(
                      height: screenHeight * 0.07,
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: Color(0xFFFEE8EC),
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                            size: screenHeight * 0.03,
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: _employeeIdSelected
                                    ? 'Enter Employee ID'
                                    : 'Enter Mobile Number',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: screenHeight * 0.02,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Submit Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TeacherDashboardScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        minimumSize: Size(double.infinity, screenHeight * 0.07),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: screenHeight * 0.022,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Login as Student
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Login as Student? ',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: screenHeight * 0.018,
                                ),
                              ),
                              TextSpan(
                                text: 'Click Here',
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontSize: screenHeight * 0.018,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginOption(
      BuildContext context,
      String title,
      bool isSelected,
      double screenHeight,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            "WITH",
            style: TextStyle(
              color: Colors.grey,
              fontSize: screenHeight * 0.015,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? _primaryColor : Colors.grey,
              fontSize: screenHeight * 0.02,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: screenHeight * 0.003,
            width: screenHeight * 0.08,
            color: isSelected ? _primaryColor : Colors.transparent,
          ),
        ],
      ),
    );
  }
}