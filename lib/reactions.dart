import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class Activity {
  final String id;
  final String username;
  final String activity;
  final String streak;
  final String profilePic;
  final String activityImage;

  Activity({
    required this.id,
    required this.username,
    required this.activity,
    required this.streak,
    required this.profilePic,
    required this.activityImage,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      username: json['username'],
      activity: json['activity'],
      streak: json['streak'].toString(),
      profilePic: json['profilePic'],
      activityImage: json['activityImage'],
    );
  }
}

const String baseUrl = 'http://10.40.87.1:5000';
// const String baseUrl = 'http://10.40.167.242:5000';

// ======================== SERVICES ========================
class DataService {
  static final client = http.Client();

  static Future<List<Activity>> fetchActivities() async {
    try {
      final response = await client
          .get(Uri.parse('$baseUrl/feeds'))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Activity.fromJson(json)).toList();
      }
      throw Exception('Failed to load activities: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<void> postReaction(String activityId, String reaction) async {
    try {
      final response = await client
          .post(
        Uri.parse('$baseUrl/reactions'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'activityId': activityId,
          'reaction': reaction,
        }),
      )
          .timeout(Duration(seconds: 5));

      if (response.statusCode != 200) {
        throw Exception('Failed to post reaction: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Reaction error: $e');
    }
  }

  static Future<int> fetchUserCoins(int userID) async {
    try {
      final response = await client
          .get(Uri.parse('$baseUrl/coins?id=${userID}'))
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        return json.decode(response.body)['coins'];
      }
      throw Exception('Failed to fetch coins: ${response.statusCode}');
    } catch (e) {
      throw Exception('Coin error: $e');
    }
  }
}

void main() async {
  // Ensure that plugin services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Get the list of available cameras
  final cameras = await availableCameras();

  // Use the first camera in the list (usually the rear camera)
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera, cameras: cameras));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  final List<CameraDescription> cameras;

  const MyApp({Key? key, required this.camera, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(camera: camera, cameras: cameras),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final CameraDescription camera;
  final List<CameraDescription> cameras;

  const HomeScreen({Key? key, required this.camera, required this.cameras}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    // Initialize the camera controller
    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.medium, // Choose a resolution preset
    );

    // Initialize the controller asynchronously
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _cameraController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      // Open the camera when the + button is pressed
      _openCamera(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<void> _openCamera(BuildContext context) async {
    try {
      // Ensure the camera is initialized
      await _initializeControllerFuture;

      // Dispose of the existing controller
      _cameraController.dispose();

      // Reinitialize the camera controller
      _cameraController = CameraController(
        widget.camera,
        ResolutionPreset.medium,
      );
      await _cameraController.initialize();

      // Navigate to the camera screen
      final images = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraScreen(
            cameraController: _cameraController,
            cameras: widget.cameras,
          ),
        ),
      );

      // Handle the captured images (if any)
      if (images != null) {
        // Navigate to the task selection screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskSelectionScreen(
              backCameraImagePath: images['backCameraImagePath'],
              frontCameraImagePath: images['frontCameraImagePath'],
            ),
          ),
        );
      }
    } catch (e) {
      // If an error occurs, log the error
      print('Error opening camera: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0
          ? FeedScreen()
          : _selectedIndex == 1
          ? Center(child: Text('Community Page'))
          : _selectedIndex == 3
          ? Task() // Replace the placeholder with the Task widget
          : Center(child: Text('Profile')),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late Future<List<Activity>> _activitiesFuture;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _activitiesFuture = DataService.fetchActivities();
  }

  Future<void> _refreshData() async {
    setState(() {
      _activitiesFuture = DataService.fetchActivities();
    });
  }

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
              child: Text(
                "Close",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
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
            'images/fire.png',
            width: 70,
            height: 70,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<Activity>>(
          future: _activitiesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading feed\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No activities found'));
            }

            return _buildFeedList(snapshot.data!);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFriendTasksPopup(context),
        backgroundColor: Colors.green,
        child: Icon(Icons.check, color: Colors.white),
      ),
    );
  }

  Widget _buildFeedList(List<Activity> activities) {
    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(10),
          itemCount: activities.length,
          itemBuilder: (context, index) => ActivityCard(
            id: activities[index].id,
            username: activities[index].username,
            activity: activities[index].activity,
            streak: activities[index].streak,
            profilePic: "${baseUrl}/${activities[index].profilePic}",
            activityImage: "${baseUrl}/${activities[index].activityImage}",
            //emojiArray: reactions[in]
          ),
        ),
      ],
    );
  }
}

// ======================== ACTIVITY CARD ========================
class ActivityCard extends StatefulWidget {
  final String id;
  final String username;
  final String activity;
  final String streak;
  final String profilePic;
  final String activityImage;
  //final List<int> emojiArray;

  ActivityCard({
    required this.id,
    required this.username,
    required this.activity,
    required this.streak,
    required this.profilePic,
    required this.activityImage,
    //required this.emojiArray,
  });

  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  late Future<int> _userCoins;
  String selectedReaction = "👍";

  @override
  void initState() {
    super.initState();
    _userCoins = DataService.fetchUserCoins(0);
    print(_userCoins);
  }

  void _showReactionShop(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Choose Reaction", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: [
                  _buildReactionButton("👍", 5),
                  _buildReactionButton("🔥", 10),
                  _buildReactionButton("😂", 8),
                  _buildReactionButton("❤️", 12),
                  _buildReactionButton("👏", 7),
                ],
              ),
              SizedBox(height: 20),
              FutureBuilder<int>(
                future: _userCoins,
                builder: (context, snapshot) => Text(
                    "Coins: ${snapshot.hasData ? snapshot.data : '...'}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReactionButton(String emoji, int cost) {
    return ElevatedButton(
      onPressed: () async {
        try {
          final coins = await _userCoins;
          if (coins >= cost) {
            await DataService.postReaction(widget.id, emoji);
            setState(() {
              selectedReaction = emoji;
              _userCoins = Future.value(coins - cost);
            });
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Not enough coins!"))
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${e.toString()}"))
          );
        }
      },
      child: Text("$emoji $cost💰"),
    );
  }

  @override
  Widget build(BuildContext context) {
    var emojiArr = ["images/emotes/like.png", "images/emotes/fire.png"];
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
                      "${widget.username} logged ${widget.activity.toLowerCase()}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    if (widget.streak.isNotEmpty)
                      Text("${widget.streak}-day streak 🔥", style: TextStyle(fontSize: 14, color: Colors.red)),
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children:
          //   widget.emojiArray.map((i) {
          //     return Image.asset(
          //       emojiArr[i],
          //       width: 30,
          //       height: 30,
          //     );
          //   }).toList(),
          // ),
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
      backgroundColor: Color(0xFF008497),
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

class CameraScreen extends StatefulWidget {
  final CameraController cameraController;
  final List<CameraDescription> cameras;

  const CameraScreen({
    Key? key,
    required this.cameraController,
    required this.cameras,
  }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  bool _isBackCamera = true;
  String? _backCameraImagePath;
  String? _frontCameraImagePath;

  @override
  void initState() {
    super.initState();
    _cameraController = widget.cameraController;
  }

  Future<void> _takePhoto() async {
    try {
      // Capture a photo with the current camera
      final image = await _cameraController.takePicture();

      if (_isBackCamera) {
        // Save the back camera photo path
        setState(() {
          _backCameraImagePath = image.path;
        });

        // Switch to the front camera
        final frontCamera = widget.cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front,
        );

        // Dispose of the current camera controller
        //_cameraController.dispose();

        // Initialize the front camera
        _cameraController = CameraController(
          frontCamera,
          ResolutionPreset.medium,
        );

        await _cameraController.initialize();

        setState(() {
          _isBackCamera = false;
        });
      } else {
        // Save the front camera photo path
        setState(() {
          _frontCameraImagePath = image.path;
        });

        // Return both image paths to the previous screen
        Navigator.pop(context, {
          'backCameraImagePath': _backCameraImagePath,
          'frontCameraImagePath': _frontCameraImagePath,
        });
      }
    } catch (e) {
      print('Error capturing photo: $e');
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isBackCamera ? 'Back Camera' : 'Front Camera'),
      ),
      body: FutureBuilder<void>(
        future: _cameraController.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePhoto,
        child: Icon(Icons.camera),
      ),
    );
  }
}

class TaskSelectionScreen extends StatelessWidget {
  final String backCameraImagePath;
  final String frontCameraImagePath;

  const TaskSelectionScreen({
    Key? key,
    required this.backCameraImagePath,
    required this.frontCameraImagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Task'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _saveActivity(context, 'Gym'),
              child: Text('Gym'),
            ),
            ElevatedButton(
              onPressed: () => _saveActivity(context, 'Study'),
              child: Text('Study'),
            ),
            ElevatedButton(
              onPressed: () => _saveActivity(context, 'Chores'),
              child: Text('Chores'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveActivity(BuildContext context, String task) {
    // Create an ActivityCard with the captured photos and selected task
    final activityCard = ActivityCard(
      id: 'a',
      username: 'User', // Replace with the actual username
      activity: 'logged $task',
      streak: '', // Add a streak if needed
      profilePic: frontCameraImagePath,
      activityImage: backCameraImagePath,
    );

    // Send the activityCard to the server (you can implement this function)
    _sendToServer(activityCard);

    // Navigate back to the feed screen
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _sendToServer(ActivityCard activityCard) async {
    // Example: Send data to a server using HTTP POST
    final url = Uri.parse('http://10.40.167.242:5000/feeds');
    final request = http.MultipartRequest('POST', url)
      ..fields['username'] = activityCard.username
      ..fields['activity'] = activityCard.activity
      ..fields['streak'] = activityCard.streak
      ..files.add(await http.MultipartFile.fromPath('profilePic', activityCard.profilePic))
      ..files.add(await http.MultipartFile.fromPath('activityImage', activityCard.activityImage));

    final response = await request.send();
    if (response.statusCode == 200) {
      print('Data sent to server successfully');
    } else {
      print('Failed to send data to server');
    }
  }
}

//////task
class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  List<Map<String, dynamic>> tasks = [];

  Future<void> sendRequest(String taskName) async {
    final url = Uri.parse('https://your-api-endpoint.com/tasks');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'task': taskName}),
    );

    if (response.statusCode == 200) {
      print('Task sent successfully: $taskName');
    } else {
      print('Failed to send task');
    }
  }

  void _addTask(String title, String category) {
    setState(() {
      tasks.add({
        'title': title,
        'category': category,
        'completed': false,
      });
    });
  }

  void _editTask(int index, String title, String category) {
    setState(() {
      tasks[index]['title'] = title;
      tasks[index]['category'] = category;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index]['completed'] = !tasks[index]['completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF008497),
        title: Text(
          'My Tasks',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TaskCategory(
                  title: 'Health',
                  count: tasks.where((task) => task['category'] == 'Health').length,
                  onTap: () => _navigateToTaskList('Health'),
                ),
                TaskCategory(
                  title: 'Study',
                  count: tasks.where((task) => task['category'] == 'Study').length,
                  onTap: () => _navigateToTaskList('Study'),
                ),
                TaskCategory(
                  title: 'Chores',
                  count: tasks.where((task) => task['category'] == 'Chores').length,
                  onTap: () => _navigateToTaskList('Chores'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskItem(
                  icon: _getIconForCategory(task['category']),
                  title: task['title'],
                  completed: task['completed'],
                  onTap: () => _navigateToTaskDetails(index),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddTask(),
        child: Icon(Icons.add),
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Health':
        return Icons.fitness_center;
      case 'Study':
        return Icons.book;
      case 'Chores':
        return Icons.local_laundry_service;
      default:
        return Icons.task;
    }
  }

  void _navigateToTaskList(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskListScreen(
          category: category,
          tasks: tasks.where((task) => task['category'] == category).toList(),
          onToggleCompletion: _toggleTaskCompletion,
          onDelete: _deleteTask,
          onEdit: _editTask,
        ),
      ),
    );
  }

  void _navigateToTaskDetails(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailsScreen(
          task: tasks[index],
          onEdit: (title, category) => _editTask(index, title, category),
          onDelete: () => _deleteTask(index),
        ),
      ),
    );
  }

  void _navigateToAddTask() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(
          onAddTask: _addTask,
        ),
      ),
    );
  }
}

class TaskCategory extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onTap;

  TaskCategory({required this.title, required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('$count tasks'),
            Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool completed;
  final VoidCallback onTap;

  TaskItem({required this.icon, required this.title, required this.completed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 40),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: completed ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            Checkbox(
              value: completed,
              onChanged: (value) => onTap(),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskListScreen extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> tasks;
  final Function(int) onToggleCompletion;
  final Function(int) onDelete;
  final Function(int, String, String) onEdit;

  TaskListScreen({
    required this.category,
    required this.tasks,
    required this.onToggleCompletion,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskItem(
            icon: _getIconForCategory(task['category']),
            title: task['title'],
            completed: task['completed'],
            onTap: () => _navigateToTaskDetails(context, index),
          );
        },
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Health':
        return Icons.fitness_center;
      case 'Study':
        return Icons.book;
      case 'Chores':
        return Icons.local_laundry_service;
      default:
        return Icons.task;
    }
  }

  void _navigateToTaskDetails(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailsScreen(
          task: tasks[index],
          onEdit: (title, category) => onEdit(index, title, category),
          onDelete: () => onDelete(index),
        ),
      ),
    );
  }
}

class TaskDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> task;
  final Function(String, String) onEdit;
  final VoidCallback onDelete;

  TaskDetailsScreen({required this.task, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _navigateToEditTask(context),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Category: ${task['category']}'),
            SizedBox(height: 10),
            Text('Status: ${task['completed'] ? 'Completed' : 'Pending'}'),
          ],
        ),
      ),
    );
  }

  void _navigateToEditTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(
          initialTitle: task['title'],
          initialCategory: task['category'],
          onAddTask: (title, category) {
            onEdit(title, category);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class AddTaskScreen extends StatelessWidget {
  final String? initialTitle;
  final String? initialCategory;
  final Function(String, String) onAddTask;

  AddTaskScreen({this.initialTitle, this.initialCategory, required this.onAddTask});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    //super.initState();
    if (initialTitle != null) _titleController.text = initialTitle!;
    if (initialCategory != null) _categoryController.text = initialCategory!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(initialTitle == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final category = _categoryController.text;
                if (title.isNotEmpty && category.isNotEmpty) {
                  onAddTask(title, category);
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

//profile

