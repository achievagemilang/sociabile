// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sociabile/constants/global_variables.dart';

import '../constants/access_token_handling.dart';
import '../constants/http_error_handling.dart';
import '../models/comment.dart';

class CommentService {
  static final String baseUrl = uri.replaceFirst("http://", "");
  static const String commentUrl = "/api/comment";

  // Adding a new comment
  Future<Comment?> postComment({
    required BuildContext context,
    required String value,
    required String postId,
  }) async {
    final fullUrl = Uri.http(baseUrl, commentUrl);

    try {
      String? token = await AccessTokenHandling
          .getTokenFromPrefs(); // Get token from SharedPreferences

      if (token == null) {
        throw Exception("Token not found");
      }
      final res = await http.post(
        fullUrl,
        headers: <String, String>{
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "value": value,
          "postId": postId,
        }),
      );

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(context, "Comment posted successfully!", true);
          });

      if (res.statusCode == 200) {
        return Comment.fromJson(json.decode(res.body)['data']);
      }
      return null;
    } catch (e) {
      showSnackbar(context, e.toString(), false);
    }
    return null;
  }

  // Editing a comment
  Future<void> editComment({
    required BuildContext context,
    required String value,
    required String postId,
    required int commentId,
  }) async {
    final fullUrl = Uri.http(baseUrl, '$commentUrl/$commentId');

    try {
      String? token = await AccessTokenHandling
          .getTokenFromPrefs(); // Get token from SharedPreferences

      if (token == null) {
        throw Exception("Token not found");
      }
      final res = await http.patch(
        fullUrl,
        headers: <String, String>{
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "value": value,
          "postId": postId,
        }),
      );

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            // showSnackbar(context, "Comment edited successfully!", true);
          });
    } catch (e) {
      showSnackbar(context, e.toString(), false);
    }
  }

  // Deleting a comment
  Future<void> deleteComment({
    required BuildContext context,
    required int commentId,
  }) async {
    final fullUrl = Uri.http(baseUrl, '$commentUrl/$commentId');

    try {
      String? token = await AccessTokenHandling
          .getTokenFromPrefs(); // Get token from SharedPreferences

      if (token == null) {
        throw Exception("Token not found");
      }
      final res = await http.delete(
        fullUrl,
        headers: <String, String>{
          'Authorization': "Bearer $token",
        },
      );

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            // showSnackbar(context, "Comment deleted successfully!", true);
          });
    } catch (e) {
      showSnackbar(context, e.toString(), false);
    }
  }

  // Fetching all comments for a post
  Future<List<Comment>?> getAllComments({
    required BuildContext context,
    required String postId,
  }) async {
    String? token = await AccessTokenHandling
        .getTokenFromPrefs(); // Get token from SharedPreferences

    if (token == null) {
      throw Exception("Token not found");
    }
    final fullUrl = Uri.http(baseUrl, commentUrl, {
      "post_id": postId,
    });

    try {
      final res = await http.get(
        fullUrl,
        headers: <String, String>{
          'Authorization': "Bearer $token",
        },
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          // showSnackbar(context, "All comments fetched successfully!", true);
        },
      );
      if (res.statusCode == 200) {
        List<dynamic> commentsData = json.decode(res.body)['data'];
        List<Comment> comments = commentsData
            .map((commentData) => Comment.fromJson(commentData))
            .toList();
        return comments;
      }
    } catch (e) {
      showSnackbar(context, e.toString(), false);
    }
    return null;
  }
}

void showSnackbar(BuildContext context, String message, bool isSuccess) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    ),
  );
}
