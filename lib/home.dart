import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // นำเข้า dio มาใช้งาน
import 'mushroomedible.dart'; // Import the edible page
import 'Poisonous.dart'; // Import the poisonous page
import 'news.dart'; // Import the news page

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  final List<String> images = [
    'lib/assets/1.png', // First image path
    'lib/assets/2.png'  // Second image path
  ];

  List<dynamic> news = [];
  bool isLoading = true;
  Dio dio = Dio();

  Future<void> getRecord() async {
    String uri = "https://mushroomroom.000webhostapp.com/Test/view_news.php";
    try {
      Response response = await dio.get(uri);
      if (response.statusCode == 200) {
        setState(() {
          news = jsonDecode(response.data);
          isLoading = false;
        });
        print(news); // Debug print to check data
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(223, 228, 194, 241), // Light purple color
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(0, 200, 185, 241), // Make Scaffold background transparent
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "Category Mushroom",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 180,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: -20,
                            right: 0,
                            child: Container(
                              height: 180,
                              child: PageView.builder(
                                controller:
                                    PageController(viewportFraction: 0.8),
                                itemCount: images.length,
                                itemBuilder: (_, i) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (i == 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MushroomEdiblePage(),
                                          ),
                                        );
                                      } else if (i == 1) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PoisonousPage(),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      height: 180,
                                      width:
                                          MediaQuery.of(context).size.width,
                                      margin:
                                          const EdgeInsets.only(right: 20),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image:
                                              AssetImage(images[i]),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "Collection of news mushrooms",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: news.length,
                        itemBuilder: (context, index) {
                          var newsItem = news[index];
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(newsItem['main_topic']), // Adjust based on your JSON structure
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailPage(newsId: newsItem['id']), // Adjust based on your JSON structure
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }