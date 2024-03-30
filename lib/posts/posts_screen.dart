import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:recepians/auth/user_profile.dart';
import 'package:recepians/auth/utils/AppConst.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List allRecipes = [];
  Map<String, int> likeCounts = {};
  Map<String, bool> likedRecipes = {};

  Future<void> _toggleLike(String recipeId) async {
    setState(() {
      likedRecipes[recipeId] = !(likedRecipes[recipeId] ?? false);

      if (likedRecipes[recipeId]!) {
        likeCounts[recipeId] = (likeCounts[recipeId] ?? 0) + 1;
        insertLikes(recipeId);
      } else {
        likeCounts[recipeId] = (likeCounts[recipeId] ?? 0) - 1;
        // If you want to remove the like from the database when unliked, you can call a removeLikes method here
      }
    });
  }

  Future<void> viewRecipes() async {
    String url = "http://10.0.2.2/recepian/view_all_recipes.php";
    try {
      var req = await http.get(Uri.parse(url));
      setState(() {
        final response = jsonDecode(req.body);
        print(response.toString());

        allRecipes = jsonDecode(req.body);
        for (final recipe in allRecipes) {
          final recipeId = recipe["recipe_id"].toString();
          likeCounts[recipeId] = 0;
          likedRecipes[recipeId] = false;
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> insertLikes(String id) async {
    String url = "http://10.0.2.2/recepian/add_likes.php";
    try {
      var req = await http.post(Uri.parse(url), body: {
        "likes_no": likeCounts[id].toString(),
        "recipe_id": id,
        "id": appConst.id.toString(),
      });

      if (req.statusCode == 200) {
        print('body:' + req.body.toString());
        var data = jsonDecode(req.body);
        print(data.toString());
        if (data['error'] == null) {
          print('..//////....');
          appConst.id = int.parse(id);

          print('.....******......');
          print('.....******......');
          Get.snackbar('success', 'Added successfully');
        } else {
          print('something went wrong');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    viewRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print(appConst.id.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts Screen"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => UserProfile(
                email: appConst.email,
                password: appConst.password,
              ));
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView.builder(
          itemCount: allRecipes.length,
          itemBuilder: (context, index) {
            final recipe = allRecipes[index];
            final recipeId = recipe["recipe_id"].toString();
            final isLiked = likedRecipes[recipeId] ?? false;
            final likeCount = likeCounts[recipeId] ?? 0;

            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: const Offset(1, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: height * .31,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/pexels-julie-aagaard-2097090.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: height * .03,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                  Colors.black.withOpacity(.4),
                                  borderRadius:
                                  BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    '30 mins',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Fredoka',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.bookmark,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Spanish Egg Risotto',
                                style: TextStyle(
                                  fontFamily: 'Fredoka-Medium',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xffFFC323),
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    recipeId,
                                    style: const TextStyle(
                                      fontFamily: 'Fredoka-Medium',
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'By Chef Srasti Gupta',
                                    style: TextStyle(
                                      fontFamily: "Fredoka-Medium",
                                      color: Colors.redAccent,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            _toggleLike(recipeId),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: height * .04,
                                              width: width * .04,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(0),
                                                child: Image.asset(
                                                  'assets/icons/heart.png',
                                                  color: isLiked
                                                      ? Colors.redAccent
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              ' $likeCount',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily:
                                                "Fredoka-Medium",
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: height * .04,
                                            width: width * .04,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(0),
                                              child: Image.asset(
                                                'assets/icons/chat.png',
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            ' 326',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily:
                                              "Fredoka-Medium",
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: height * .04,
                                            width: width * .04,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(0),
                                              child: Image.asset(
                                                'assets/icons/share.png',
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            ' 47',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily:
                                              "Fredoka-Medium",
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 5,
                                ),
                                height: height * .05,
                                // width: width * .1,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius:
                                  BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(7),
                                    child: Image.asset(
                                      'assets/icons/follow.png',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
