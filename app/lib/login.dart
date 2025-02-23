import 'package:fkfa2/working.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'register.dart'; // Import the registration page


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Buddies',
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = "";
  bool isLoading = false;

  Future<void> loginUser() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    final url = Uri.parse('${baseUrl}/auth/login'); // Replace with your server URL

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": usernameController.text,
          "password": passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Success: Navigate to Home Page
        Navigator.pop(context);
      } else {
        // Failure: Show error message
        setState(() {
          errorMessage = "Invalid email or password!";
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = "Network error. Please try again.";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title: Bigger, Bubbly, and More Teal
              Column(
                children: [
                  Text(
                    "task",
                    style: GoogleFonts.poppins(
                      fontSize: 50, // Bigger font size
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: Colors.teal[300]!,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "buddies",
                    style: GoogleFonts.poppins(
                      fontSize: 65, // Even Bigger & Bubbly!
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Colors.teal[400]!,
                          blurRadius: 6,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Username Field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(border: InputBorder.none, hintText: "Email"),
                ),
              ),
              SizedBox(height: 10),

              // Password Field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(border: InputBorder.none, hintText: "Password"),
                ),
              ),
              SizedBox(height: 10),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text("forgot password", style: TextStyle(color: Colors.teal[800])),
                ),
              ),
              SizedBox(height: 10),

              // Show Error Message
              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),

              // Login Button
              SizedBox(height: 10),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[800],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text("login", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 30),

              // Create an Account Link
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Text("Don't have an account? Create one", style: TextStyle(color: Colors.teal[800])),
              ),

              SizedBox(height: 30),

              // Motivational Tagline
              Text("friends keep friends accountable",
                  style: GoogleFonts.poppins(
                    fontStyle: FontStyle.italic,
                    fontSize: 18, // Slightly bigger
                    color: Colors.teal[700],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy Home Page after login
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(child: Text("Welcome to Task Buddies!", style: TextStyle(fontSize: 20))),
    );
  }
}