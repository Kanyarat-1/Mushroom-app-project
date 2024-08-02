import 'package:flutter/material.dart';

class DataMushroomPage extends StatelessWidget {
  final Map<String, dynamic> mushroomData;

  const DataMushroomPage({Key? key, required this.mushroomData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(mushroomData['image']);  // Debugging line to print the image URL

    return Scaffold(
      appBar: AppBar(
        title: Text(mushroomData['mush_name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              mushroomData['image'],
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error);
              },
            ),
            SizedBox(height: 16),
            Text(
              'ชื่อ: ${mushroomData['mush_name']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'ชื่อวิทยาศาสตร์: ${mushroomData['sci_name']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'รายละเอียด: ${mushroomData['mush_detail']}',
              style: TextStyle(fontSize: 20),
            ),
            // Add more fields as necessary
          ],
        ),
      ),
    );
  }
}
