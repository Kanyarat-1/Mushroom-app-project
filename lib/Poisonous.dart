import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/mushroomdata.dart';

class PoisonousPage extends StatefulWidget {
  const PoisonousPage({Key? key}) : super(key: key);

  @override
  State<PoisonousPage> createState() => _PoisonousPageState();
}

class _PoisonousPageState extends State<PoisonousPage> {
  List userdata = [];
  List filteredData = [];
  String searchText = '';
  bool isLoading = true;

  Future<void> getrecord() async {
    String uri = "https://mushroomroom.000webhostapp.com/Test/signup/view_poisonous.php";
    try {
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        setState(() {
          userdata = jsonDecode(response.body);
          filteredData = List.from(userdata);
          isLoading = false;
        });
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getrecord();
  }

  void search(String query) {
    setState(() {
      filteredData = userdata.where((item) =>
          item["mush_name"].toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mushroom Poisonous")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          // Action when search button is pressed
                        },
                      ),
                    ),
                    onChanged: (value) {
                      search(value); // Call search function every time TextField changes
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey), // Set border color
                            borderRadius: BorderRadius.circular(10), // Set rounded corners for Card
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Set rounded corners for image
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10), // Set padding for ListTile
                              title: Text(filteredData[index]["mush_name"]),
                              leading: SizedBox(
                                width: 80, // Set width of the image
                                height: 80, // Set height of the image
                                child: Image.network(
                                  filteredData[index]["image"],
                                  fit: BoxFit.cover, // Fit image within the bounds
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error);
                                  },
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DataMushroomPage(
                                      mushroomData: filteredData[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
