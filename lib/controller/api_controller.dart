import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_example/models/post.dart';

class ApiController {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': post.userId,
        'id': post.id,
        'title': post.title,
        'body': post.body,
      }),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<void> deletePost(int postId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$postId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }

  Future<Post> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${post.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': post.userId,
        'id': post.id,
        'title': post.title,
        'body': post.body,
      }),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }
}
