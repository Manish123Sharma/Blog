import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../widgets/post_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HiveBlogFeed extends StatefulWidget {
  @override
  _HiveBlogFeedState createState() => _HiveBlogFeedState();
}

class _HiveBlogFeedState extends State<HiveBlogFeed> {
  List<BlogPost> posts = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    final url = Uri.parse('https://api.hive.blog/');
    final headers = {
      'accept': 'application/json, text/plain, */*',
      'content-type': 'application/json',
    };
    final payload = {
      'id': 1,
      'jsonrpc': '2.0',
      'method': 'bridge.get_ranked_posts',
      'params': {
        'sort': 'trending',
        'tag': '',
        'observer': 'hive.blog',
        'limit': 20
      }
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['result'] != null) {
          final postsData = responseData['result'] as List;
          setState(() {
            posts = postsData.map((post) => BlogPost.fromJson(post)).toList();
            isLoading = false;
          });
        } else {
          setState(() {
            error = 'No data found in response';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          error = 'Failed to load posts: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error fetching posts: $e';
        isLoading = false;
      });
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('All posts'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: fetchPosts,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : error != null
            ? Center(child: Text(error!))
            : posts.isEmpty
            ? Center(child: Text('No posts found'))
            : ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return PostCard(post: post);
          },
        ),
      ),
    );
  }
}
