import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/constants/http_error_handling.dart';
import 'package:sociabile/constants/utility.dart';

import '../constants/access_token_handling.dart';
import '../models/post.dart';

class PostService {
  static final String postUrl = "$uri/api/post";

  // Fetching posts with pagination
  Future<List<Post>> fetchPosts({
    required BuildContext context,
    required int page,
    required int take,
  }) async {
    List<Post> posts = [];
    try {
      String? token = await AccessTokenHandling
          .getTokenFromPrefs(); // Get token from SharedPreferences

      if (token == null) {
        throw Exception("Token not found");
      }
      http.Response res = await http.get(
        Uri.parse('$postUrl?page=$page&take=$take'),
        headers: <String, String>{
          'Authorization': "Bearer $token",
        },
      );

      var jsonResponse = jsonDecode(res.body);
      if (jsonResponse['status'] == true) {
        for (var postData in jsonResponse['data']) {
          posts.add(Post.fromJson(postData));
        }
      }
      print(posts.length);
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackbar(context, "Posts fetched successfully!", true);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return posts;
  }

  // Fetching a specific post
  Future<Post?> fetchPostDetails({
    required BuildContext context,
    required String postId,
  }) async {
    Post? post;
    try {
      String? token = await AccessTokenHandling
          .getTokenFromPrefs(); // Get token from SharedPreferences

      if (token == null) {
        throw Exception("Token not found");
      }
      http.Response res = await http.get(
        Uri.parse('$postUrl/$postId'),
        headers: <String, String>{
          'Authorization': "Bearer $token",
        },
      );

      var jsonResponse = jsonDecode(res.body);
      if (jsonResponse['status'] == true) {
        post = Post.fromJson(jsonResponse['data']);
      }

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackbar(context, "Post details fetched successfully!", true);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return post;
  }

  // Creating a new post
  void createPost({
    required BuildContext context,
    required String title,
    required String content,
    required String picturePath,
    required File imageFile,
  }) async {
    try {
      print("PICTURE: $picturePath");
      String? token = await AccessTokenHandling
          .getTokenFromPrefs(); // Get token from SharedPreferences

      if (token == null) {
        throw Exception("Token not found");
      }
      var request = http.MultipartRequest('POST', Uri.parse(postUrl));

      // Uint8List data = await imageFile.readAsBytes();
      // List<int> list = data.cast();

      // print(data);
      // print("SEPARATEOROJO");
      // print(list);

      // request.files.add(await http.MultipartFile.fromBytes('picture', list,
      //     filename: "myFiles.png"));

      final image =
          await http.MultipartFile.fromPath('picture', imageFile.path);
      request.files.add(image);

      request.fields['title'] = title;
      request.fields['content'] = content;
      // request.fields['picture'] = base64Encode(await imageFile.readAsBytes());

      print("HAI");
      // print(request.fields['picture']);

      request.headers['Authorization'] =
          "Bearer $token"; // replace YOUR_TOKEN_HERE

      var res = await request.send();
      var responseBody = await http.Response.fromStream(res);

      print(responseBody.body);

      httpErrorHandling(
        response: responseBody,
        context: context,
        onSuccess: () async {
          showSnackbar(context, "Post created successfully!", true);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // Continuing from the previous `PostService`:

// Editing an existing post
  Future<void> editPost({
    required BuildContext context,
    required String postId,
    required String title,
    required String content,
    String? picturePath, // This can be null if not provided
  }) async {
    try {
      String? token = await AccessTokenHandling
          .getTokenFromPrefs(); // Get token from SharedPreferences

      if (token == null) {
        throw Exception("Token not found");
      }
      var request =
          http.MultipartRequest('PATCH', Uri.parse('$postUrl/$postId'));
      if (picturePath != null) {
        request.files
            .add(await http.MultipartFile.fromPath('picture', picturePath));
      }
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.headers['Authorization'] =
          "Bearer $token"; // replace YOUR_TOKEN_HERE

      var res = await request.send();
      var responseBody = await http.Response.fromStream(res);

      print(responseBody.body);

      httpErrorHandling(
        response: responseBody,
        context: context,
        onSuccess: () async {
          showSnackbar(context, "Post edited successfully!", true);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

// Deleting a post
  void deletePost({
    required BuildContext context,
    required String postId,
  }) async {
    try {
      String? token = await AccessTokenHandling
          .getTokenFromPrefs(); // Get token from SharedPreferences

      if (token == null) {
        throw Exception("Token not found");
      }
      http.Response res = await http.delete(
        Uri.parse('$postUrl/$postId'),
        headers: <String, String>{
          'Authorization': "Bearer $token", // replace YOUR_TOKEN_HERE
        },
      );

      print(res.body);

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackbar(context, "Post deleted successfully!", true);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // Continuing from the previous `PostService`:

// Liking or disliking a post
  void likeOrDislikePost({
    required BuildContext context,
    required String postId,
    required String likeType, // Expected values: 'LIKE' or 'DISLIKE'
  }) async {
    final postLikeUrl = "$postUrl/post-like";

    try {
      String? token = await AccessTokenHandling
          .getTokenFromPrefs(); // Get token from SharedPreferences

      if (token == null) {
        throw Exception("Token not found");
      }
      http.Response res = await http.post(
        Uri.parse(postLikeUrl),
        headers: <String, String>{
          'Authorization': "Bearer $token", // replace YOUR_TOKEN_HERE
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "likeType": likeType,
        }),
      );

      print(res.body);

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          String message = (likeType == 'LIKE')
              ? "Post liked successfully!"
              : "Post disliked successfully!";
          showSnackbar(context, message, true);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
