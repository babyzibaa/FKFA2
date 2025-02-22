import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';  // For File

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  bool isEditing = false;
  String profileImage = 'assets/images/mikeWazowski.webp';  // Default profile image
  File? _selectedImage;  // This is the selected image

  @override
  void initState() {
    super.initState();
    nameController.text = 'your name';
    bioController.text = 'Add Bio';
  }

  // Function to pick an image from gallery
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Colors.blueGrey[900],
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _selectedImage == null
                    ? AssetImage(profileImage)  // Default image
                    : FileImage(_selectedImage!) as ImageProvider,  // Selected image
              ),
            ),
            SizedBox(height: 10),

            // Name Field
            isEditing
                ? TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            )
                : Text(
              nameController.text,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Bio Field
            isEditing
                ? TextField(
              controller: bioController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
              ),
            )
                : Text(
              bioController.text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),

            // Edit and Save Button
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isEditing = !isEditing;
                });
              },
              child: Text(isEditing ? 'Save' : 'Edit Profile'),
            ),
            SizedBox(height: 20),

            // Sign Out Button
            // OutlinedButton(
             // onPressed: () {
              //  print('User signed out');
              //},
              //child: Text('Sign Out'),
            //),
          ],
        ),
      ),
    );
  }
}
