import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReactionPage(),
    );
  }
}

class ReactionPage extends StatelessWidget {
  ReactionPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> reactions = [
    {"emoji": "🔥", "price": 50},
    {"emoji": "👍", "price": 100},
    {"emoji": "🤯", "price": 5},
    {"emoji": "🌸", "price": 10},
    {"emoji": "🏋️", "price": 50},
    {"emoji": "😵‍💫", "price": 150},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            "Send Reaction!",
            style: GoogleFonts.balooBhai2(  // Use a playful font
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(3, 3)
                )
              ]
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: reactions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(
                      reactions[index]["emoji"],
                      style: const TextStyle(fontSize: 40),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${reactions[index]["price"]}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.monetization_on, color: Colors.orange, size: 16),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        //  const Spacer(),
          //BottomNavBar(),
        ],
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.home, color: Colors.white, size: 30),
          Icon(Icons.people, color: Colors.white, size: 30),
          Icon(Icons.add_circle, color: Colors.white, size: 30),
          Icon(Icons.assignment, color: Colors.white, size: 30),
          CircleAvatar(
            backgroundImage: NetworkImage("https://via.placeholder.com/50"), // Replace with your image URL
            radius: 15,
          ),
        ],
      ),
    );
  }

