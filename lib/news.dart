import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsDetailPage extends StatefulWidget {
  final String newsId;

  NewsDetailPage({required this.newsId});

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late Future<Map<String, dynamic>> _futureContent;

  @override
  void initState() {
    super.initState();
    _futureContent = fetchNewsContent(widget.newsId);
  }

  Future<Map<String, dynamic>> fetchNewsContent(String newsId) async {
  String uri = "https://mushroomroom.000webhostapp.com/Test/signup/get_news_content.php?id=$newsId";

  try {
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var jsonResponse = jsonDecode(response.body);

      // Log the decoded JSON to verify structure
      print('Decoded JSON: $jsonResponse');

      if (jsonResponse is Map<String, dynamic> &&
          jsonResponse.containsKey('subtopic') &&
          jsonResponse.containsKey('image') &&
          jsonResponse.containsKey('created_at')) {
        return {
          'image': jsonResponse['image'],
          'subtopic': jsonResponse['subtopic'],
          'created_at': jsonResponse['created_at'],
        };
      } else {
        throw Exception('Unexpected JSON format or missing keys');
      }
    } else {
      throw Exception('Failed to load news content');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}



 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('News Detail'),
    ),
    body: FutureBuilder<Map<String, dynamic>>(
      future: _futureContent,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          var data = snapshot.data!;
          String imageUrl = data['image'] ?? '';
          print('Image URL: $imageUrl');  // Debugging line

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageUrl.isNotEmpty)
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print('Image loading error: $error');  // Detailed error log
                      return Text('Error loading image');
                    },
                  ),
                  SizedBox(height: 16.0),
                if (data.containsKey('created_at'))
                  Text(
                    'Date: ${data['created_at']}',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                SizedBox(height: 16.0),
                if (data.containsKey('subtopic'))
                  Text(
                    data['subtopic'] ?? 'No subtopic available',
                    style: TextStyle(fontSize: 18),
                  ),
              ],
            ),
          );
        } else {
          return Center(
            child: Text('No data available'),
          );
        }
      },
    ),
  );
}
}