import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageAdminDashboard extends StatefulWidget {
  @override
  _ImageAdminDashboardState createState() => _ImageAdminDashboardState();
}

class _ImageAdminDashboardState extends State<ImageAdminDashboard> {
  List<String> _imageUrls = []; // Initialize _imageUrls with an empty list

  // Fetch list of images from Firebase Storage
  Future<void> _fetchImages() async {
    try {
      final ListResult result = await FirebaseStorage.instance.ref().listAll();
      setState(() {
        _imageUrls = result.items.map((item) => item.fullPath).toList();
      });
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchImages(); // Fetch images when widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchImages,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: _imageUrls.isEmpty // Check if _imageUrls is empty before building UI
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _imageUrls.length,
              itemBuilder: (context, index) {
                final imageUrl = _imageUrls[index];
                return ListTile(
                  title: Text(imageUrl),
                  onTap: () {
                    // Implement action when image is selected
                    // For example, display the image in a new screen
                    // or perform further processing with the image URL
                  },
                );
              },
            ),
    );
  }
}
