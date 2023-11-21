import 'package:flutter/material.dart';
import 'package:latihanresponsi/blogs/blogs.dart';
import 'package:latihanresponsi/news/news.dart';
import 'package:latihanresponsi/reports/reports.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Flight News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xFFF8F2FA),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePageState(),
        '/news': (context) => News(),
        '/blogs': (context) => Blogs(),
        '/reports': (context) => Reports(),
      },
    );
  }
}

class HomePageState extends StatelessWidget {
  const HomePageState({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SPACE FLIGHT NEWS',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildCard(
                context,
                'https://cdn.pixabay.com/photo/2015/02/15/09/33/news-636978_960_720.jpg',
                'NEWS',
                'Get an overview of the latest Spaceflight news,from various source! Easily link your users to the right websites',
                '/news',
              ),
              const SizedBox(height: 20),
              buildCard(
                context,
                'https://img.freepik.com/free-photo/toy-bricks-table-with-word-blog_144627-47465.jpg',
                'BLOGS',
                'Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast',
                '/blogs',
              ),
              const SizedBox(height: 20),
              buildCard(
                context,
                'https://www.fisdom.com/wp-content/uploads/2021/11/Report.webp',
                'REPORTS',
                'Space Stations and other missions often publish their data. With SNAPi, you can include it in your app as well!',
                '/reports',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(
      BuildContext context, String imageUrl, String title, String description,  String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route); // Navigate to respective routes
      },
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color(0xFFF8F2FA),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200.0,
              child: Center(
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundColor:
                  Colors.white,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 3.0, bottom: 3.0, right: 15.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0,top: 3.0, bottom: 3.0,right: 15.0),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}