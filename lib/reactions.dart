import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    FeedScreen(),
    Center(child: Text('Community Page')),
    Center(child: Text('Create Post')),
    Center(child: Text('Activity List')),
    Center(child: Text('Profile')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Switches between different pages
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF008497), // Set a distinct color for visibility
        elevation: 0,
        title: Text(
          'Feed',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/logo.png', // Make sure it's in the assets folder
            width: 70,
            height: 70,
            //fit: BoxFit.contain,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          ActivityCard(
            username: "Jessica",
            activity: "logged studying",
            streak: "2-day streak 🔥",
            profilePic: "https://media.istockphoto.com/id/1399395748/photo/cheerful-business-woman-with-glasses-posing-with-her-hands-under-her-face-showing-her-smile.jpg?s=612x612&w=0&k=20&c=EbnuxLE-RJP9a08h2zjfgKUSFqmjGubk0p6zwJHnbrI=",
            activityImage: "https://media.istockphoto.com/id/1354989842/photo/banner-with-books-business-and-education-background-back-to-school-concept.jpg?s=612x612&w=0&k=20&c=HI-geEWN-ugepkQ0MQ785qnLxSKk1TsRtUY1SfWbp6g=",
          ),
          ActivityCard(
            username: "Kenzi",
            activity: "logged gym",
            streak: "",
            profilePic: "https://emilyrobinson.fit/wp-content/uploads/2023/08/img_4299-edited.jpeg",
            activityImage: "https://lamovingstar.com/wp-content/uploads/2023/02/2023-02-06-08.44.21.jpg",
          ),
          ActivityCard(
            username: "Jason",
            activity: "logged walking",
            streak: "5-day streak",
            profilePic: "https://media.istockphoto.com/id/484049872/photo/theres-no-better-feeling-than-achieving-your-fitness-goals.jpg?s=612x612&w=0&k=20&c=ZxKRZMIm1gcSnPEmFzD6Dc_2oakAIQXRMsTeVaHjQ_g=",
            activityImage: "https://mana.md/wp-content/uploads/2017/04/Woman-walking-e1490296724295.jpg",
          ),
        ],
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String username;
  final String activity;
  final String streak;
  final String profilePic;
  final String activityImage;

  ActivityCard({
    required this.username,
    required this.activity,
    required this.streak,
    required this.profilePic,
    required this.activityImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$username $activity",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                if (streak.isNotEmpty)
                  Text(streak, style: TextStyle(fontSize: 14, color: Colors.red)),
              ],
            ),
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                child: Image.network(
                  activityImage,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(profilePic),
                ),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'images/r.png',
                width: 30,
                height: 30,
              ),
              Image.asset(
                'images/r.png',
                width: 30,
                height: 30,
              ),
              Image.asset(
                'images/r.png',
                width: 30,
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  BottomNavBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF008497), // Ensures bottom bar stays colored
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community'),
        BottomNavigationBarItem(icon: Icon(Icons.add, size: 35), label: 'New'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Activity'),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage("https://via.placeholder.com/100"),
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
    );
  }
}
