import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/model/post.dart';
import 'package:sociabile/page/create_post_page.dart';
import 'package:sociabile/page/profile_page.dart';
import 'package:sociabile/widgets/social_media_post_card.dart';

import '../model/comment.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});
  static const String routeName = "/main-page";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Post> posts = [
    Post(
      username: 'Yudha',
      major: 'Computer Science 22',
      text: 'This is a sample post text. #Flutter',
      imageURL: 'https://example.com/sample_image.jpg',
      comments: [
        Comment(
          username: 'User1',
          major: '2 hours ago',
          text: 'Great post!',
          profileImageURL: 'https://example.com/profile1.jpg',
        ),
        Comment(
          username: 'User2',
          major: '1 hour ago',
          text: 'I agree.',
          profileImageURL: 'https://example.com/profile2.jpg',
        ),
        Comment(
          username: 'User3',
          major: '30 minutes ago',
          text: 'Nice photo!',
          profileImageURL: 'https://example.com/profile3.jpg',
        ),
      ],
    ),
    Post(
      username: 'Yudha',
      major: 'Computer Science 22',
      text: 'This is a sample post text. #Flutter',
      imageURL: 'https://example.com/sample_image.jpg',
      comments: [
        Comment(
          username: 'User1',
          major: '2 hours ago',
          text: 'Great post!',
          profileImageURL: 'https://example.com/profile1.jpg',
        ),
        Comment(
          username: 'User2',
          major: '1 hour ago',
          text: 'I agree.',
          profileImageURL: 'https://example.com/profile2.jpg',
        ),
        Comment(
          username: 'User3',
          major: '30 minutes ago',
          text: 'Nice photo!',
          profileImageURL: 'https://example.com/profile3.jpg',
        ),
      ],
    ),
  ];
  // late User user;

  @override
  void initState() {
    // loadMovies();
    super.initState();
    // user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 21,
                            child: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage("assets/RISTEK.png")
                                    as ImageProvider

                                // backgroundImage: (user.imagePath
                                //         .contains('assets/'))
                                // ? AssetImage(user.imagePath) as ImageProvider
                                // : FileImage(File(user.imagePath)),
                                ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Arvin",
                              style: TextStyle(
                                  color: GlobalVariables.secondaryColor,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              "Computer Science 2022",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 186, 186, 186),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      splashColor: GlobalVariables.secondaryColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreatePostPage(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: GlobalVariables.purpleColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: posts.map((post) {
                    return Center(
                      child: SocialMediaPostCard(post: post),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
