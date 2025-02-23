import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController(); // Changed to "Name"
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String errorMessage = "";
  bool isLoading = false;

  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        errorMessage = "Passwords do not match!";
        isLoading = false;
      });
      return;
    }

    final url = Uri.parse('http://10.40.167.242:5000/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": nameController.text, // Updated field from "username" to "name"
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      if (response.statusCode == 201) {
        // Success: Navigate back to login page
        Navigator.pop(context);
      } else {
        setState(() {
          errorMessage = "Registration failed. Try again.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Network error. Please check your connection.";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Bubblier "task buddies" Header
                  Column(
                    children: [
                      Text(
                        "task",
                        style: GoogleFonts.poppins(
                          fontSize: 50,
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
                          fontSize: 65,
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

                  // Name Field (Updated from Username)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(border: InputBorder.none, hintText: "Name"), // Updated label
                    ),
                  ),
                  SizedBox(height: 10),

                  // Email Field
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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

                  // Confirm Password Field
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(border: InputBorder.none, hintText: "Confirm Password"),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Show Error Message
                  if (errorMessage.isNotEmpty)
                    Text(errorMessage, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),

                  // Register Button
                  SizedBox(height: 10),
                  isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[800],
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    child: Text("Register", style: TextStyle(color: Colors.white)),
                  ),

                  SizedBox(height: 15),

                  // Back to Login
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Already have an account? Login", style: TextStyle(color: Colors.teal[800])),
                  ),

                  SizedBox(height: 30),

                  // Motivational Tagline
                  Text(
                    "friends keep friends accountable",
                    style: GoogleFonts.poppins(
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      color: Colors.teal[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}