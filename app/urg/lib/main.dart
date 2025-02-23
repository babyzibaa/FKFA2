import 'package:flutter/material.dart';

// Add this import

void main() async {
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class FeedScreen extends StatelessWidget {
  void _showFriendTasksPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(
            child: Text(
              "Friends' Tasks",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black87),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(),
              _buildTaskItem("Jessica", "Studying", true, context),
              _buildTaskItem("Marie", "Gym", false, context),
              _buildTaskItem("Jason", "Walking", true, context),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTaskItem(String name, String task, bool completed, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$name - $task",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          if (!completed)
            IconButton(
              icon: Icon(Icons.touch_app, color: Colors.redAccent),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Reminder sent to $name!")),
                );
              },
            )
          else
            Icon(Icons.check_circle, color: Colors.green),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF008497),
        elevation: 0,
        title: Text(
          'Feed',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/logo.png',
            width: 70,
            height: 70,
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
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
                streak: "5-day streak 🔥",
                profilePic: "https://media.istockphoto.com/id/484049872/photo/theres-no-better-feeling-than-achieving-your-fitness-goals.jpg?s=612x612&w=0&k=20&c=ZxKRZMIm1gcSnPEmFzD6Dc_2oakAIQXRMsTeVaHjQ_g=",
                activityImage: "https://mana.md/wp-content/uploads/2017/04/Woman-walking-e1490296724295.jpg",
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () => _showFriendTasksPopup(context),
              backgroundColor: Colors.green,
              child: Icon(Icons.check, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityCard extends StatefulWidget {
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
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  int userCoins = 100; // Example: User starts with 100 coins
  String selectedReaction = "👍"; // Default reaction

  void _showReactionShop(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the sheet to adjust dynamically
      builder: (context) {
        return SingleChildScrollView( // Prevents overflow
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensures it doesn't take too much space
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Choose a reaction", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: [
                    _buildReactionButton(context, "👍", 5),
                    _buildReactionButton(context, "🔥", 10),
                    _buildReactionButton(context, "😂", 8),
                    _buildReactionButton(context, "❤️", 12),
                    _buildReactionButton(context, "👏", 7),
                  ],
                ),
                SizedBox(height: 20),
                Text("Coins: $userCoins", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReactionButton(BuildContext context, String emoji, int cost) {
    return ElevatedButton(
      onPressed: () {
        if (userCoins >= cost) {
          setState(() {
            userCoins -= cost;
            selectedReaction = emoji;
          });
          Navigator.pop(context); // Close the shop
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Not enough coins!"))
          );
        }
      },
      child: Text("$emoji $cost💰"),
    );
  }

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.username} ${widget.activity}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    if (widget.streak.isNotEmpty)
                      Text(widget.streak, style: TextStyle(fontSize: 14, color: Colors.red)),
                  ],
                ),
                Row(
                  children: [
                    Text(selectedReaction, style: TextStyle(fontSize: 18)),
                    IconButton(
                      icon: Icon(Icons.emoji_emotions_outlined, color: Colors.orange),
                      onPressed: () => _showReactionShop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                child: Image.network(
                  widget.activityImage,
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
                  backgroundImage: NetworkImage(widget.profilePic),
                ),
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