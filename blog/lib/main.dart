import 'package:flutter/material.dart';
import 'widgets/hive_blog_feed.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Blog Feed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HiveBlogFeed(),
      debugShowCheckedModeBanner: false,
    );
  }
}
