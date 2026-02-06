import 'package:flutter/material.dart';
import '../network/api_service.dart';
import '../models/category_model.dart';

// main home page of the app
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// this state holds the logic and ui for the home page
class _HomePageState extends State<HomePage> {
  // used to call api functions
  final ApiService _apiService = ApiService();

  // list to store categories coming from the api
  List<CategoryModel> categories = [];

  // used to show loading indicator while data is loading
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // load categories when the page starts
    _loadCategories();
  }

  // function that gets categories from the api
  Future<void> _loadCategories() async {
    try {
      final fetchedCategories = await _apiService.getCategories();
      setState(() {
        // save data and stop loading
        categories = fetchedCategories;
        isLoading = false;
      });
    } catch (e) {
      // if error happens, stop loading and print error
      setState(() {
        isLoading = false;
      });
      print('error loading categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // top app bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        // menu button on the left
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),

        // app logo in the center
        title: Image.asset(
          'assets/images/logo.png',
          width: 210,
          height: 210,
          fit: BoxFit.contain,
        ),
        centerTitle: true,

        // profile icon on the right
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),

      // main page content
      body: Column(
        children: [
          // search bar section
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'search any product..',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.mic),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // title and action buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // section title
                Text(
                  'all featured',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),

                // sort and filter buttons
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: Text('sort'),
                      label: Icon(Icons.swap_vert),
                    ),
                    SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Text('filter'),
                      label: Icon(Icons.filter_alt_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // horizontal list of categories
          SizedBox(
            height: 100,
            child: isLoading
                // show loading while data is coming
                ? Center(child: CircularProgressIndicator())
                // show categories when data is ready
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Column(
                          children: [
                            // category image
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/photo${index + 1}.jpg',
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) {
                                    return Icon(Icons.image);
                                  },
                                ),
                              ),
                            ),

                            SizedBox(height: 8),

                            // category name
                            Text(
                              category.name,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
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
