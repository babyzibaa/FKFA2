import 'package:flutter/material.dart';

void main() {
  runApp(task());
}

class Task extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: task(),
    );
  }
}

class task extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'my tasks',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                TaskCategory(title: 'health', count: 2),
                TaskCategory(title: 'study', count: 4),
                TaskCategory(title: 'chores', count: 5),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                TaskItem(icon: Icons.fitness_center, title: 'gym', count: 2),
                TaskItem(icon: Icons.local_laundry_service, title: 'laundry', count: 4),
                TaskItem(icon: Icons.book, title: 'study', count: 6),
                TaskItem(icon: Icons.menu_book, title: 'read', count: 2),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: ''),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/50'),
              radius: 12,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

class TaskCategory extends StatelessWidget {
  final String title;
  final int count;

  TaskCategory({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class TaskItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;

  TaskItem({required this.icon, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('+$count logged'),
        ],
      ),
    );
  }
}