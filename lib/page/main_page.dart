// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/model/post_display.dart';
import 'package:sociabile/models/post.dart';
import 'package:sociabile/models/user.dart';
import 'package:sociabile/provider/auth_provider.dart';
import 'package:sociabile/widgets/social_media_post_card.dart';

import '../model/comment_display.dart';
import '../models/comment.dart';
import '../services/comment_services.dart';
import '../services/post_services.dart';
import 'create_post_page.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static const String routeName = "/main-page";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<PostDisplay> posts = [];
  List<Comment> comments = [];

  late PostService postService;
  late CommentService commentService;

  late User? user;

  @override
  void initState() {
    super.initState();
    postService = PostService();
    commentService = CommentService();
    _fetchPosts();
  }

  void _fetchPosts() async {
    List<Post> fetchedPosts = await postService.fetchPosts(
      context: context,
      page: 1,
      take: 10, // adjust this to your desired number
    );

    List<PostDisplay> posts = fetchedPosts
        .map(
          (post) => post.toPostDisplay(
            "User ID ${post.userId}",
            'RISTEK 2023',
          ),
        )
        .toList();

    for (var post in posts) {
      List<Comment>? fetchedComments = await commentService.getAllComments(
        context: context,
        postId: post.id,
      );
      if (fetchedComments != null) {
        comments.addAll(fetchedComments);
        List<CommentDisplay> commentDisplays = fetchedComments
            .map(
              (comment) => comment.toCommentDisplay(
                "User ID ${comment.userId}",
                'RISTEK 2023',
              ),
            )
            .toList();
        post.setComments = commentDisplays;
      }
    }

    setState(() {
      this.posts = posts;
    });
  }

  void _refreshPosts() {
    _fetchPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AuthProvider>(context).user;
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
                              builder: (context) => const ProfilePage(),
                            ),
                          ).then((_) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainPage(),
                                ));
                          }),
                          child: CircleAvatar(
                            radius: 21,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: user!.photoUrl == null
                                  ? const AssetImage("assets/RISTEK.png")
                                      as ImageProvider
                                  : NetworkImage(user!.photoUrl!),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user!.firstName,
                              style: const TextStyle(
                                  color: GlobalVariables.secondaryColor,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const Text(
                              "RISTEK 2023",
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
                            builder: (context) => const CreatePostPage(),
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
                      child: SocialMediaPostCard(
                        post: post,
                        onPostDeleted: _refreshPosts,
                      ),
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
