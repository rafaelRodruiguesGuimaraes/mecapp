import 'package:app/ui/components/drawer_home.dart';
import 'package:app/ui/components/text_input.dart';
import 'package:app/ui/screens/home_page/components/article_item.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'components/home_search_field.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool articles = true;
  bool courses = false;

  bool isLikedButton = false;

  List categories = [];
  List articleList = [];

  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    var categoriesRes = await db.collection('categories').get();

    categoriesRes.docs.forEach(
      (e) async {
        var item = e.data();
        item["id"] = e.id;
        categories.add(item);
      },
    );

    var articlesRes = await db.collection('articles').get();

    articlesRes.docs.forEach(
      (e) async {
        var item = e.data();
        item["id"] = e.id;
        articleList.add(item);
      },
    );

    setState(
      () {
        articleList = articleList.reversed.toList();
        categories = categories.reversed.toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: HomeDrawer(onTap: () {
        //logout();
      }),
      appBar: AppBar(
        title: Text('O Mecânico'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Center(
            child: Column(
              children: [
                Form(
                  key: null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Row(
                        children: [
                          Flexible(
                            child: HomeSearchField(),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: GestureDetector(
                              child: Center(
                                child: Icon(
                                  Icons.filter_list,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        height: 150.0,
                        width: MediaQuery.of(context).size.width,
                        child: Carousel(
                          borderRadius: true,
                          autoplayDuration: Duration(seconds: 10),
                          autoplay: true,
                          animationDuration: Duration(milliseconds: 1000),
                          showIndicator: false,
                          images: [
                            NetworkImage(
                                'https://lirp.cdn-website.com/ba4a4629/dms3rep/multi/opt/150964-conheca-os-7-tipos-de-anuncio-mais-relevantes-no-marketing-digital-1024x512-640w.jpg'),
                            NetworkImage(
                                'https://www.monsterinsights.com/wp-content/uploads/2018/02/How-to-Find-AdWords-Reports-in-GA.png'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Categorias:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            width: 5.0,
                          ),
                          itemCount: categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 60.0,
                              child: GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
                                      categories[index]['title'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              {
                                setState(() {
                                  articles = true;
                                  courses = false;
                                });
                              }
                            },
                            child: Text(
                              'Matéias',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      articles ? Colors.black : Colors.black26),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              {
                                setState(() {
                                  articles = false;
                                  courses = true;
                                });
                              }
                            },
                            child: Text(
                              'Curso do Mecânico',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: courses ? Colors.black : Colors.black26,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: MediaQuery.of(context).size.height,
                        child: ListView.separated(
                          itemCount: articleList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ArticleItem(
                              title: articleList[index]['title'],
                              subTitle: articleList[index]['subtitle'],
                              isExclusive: articleList[index]['is_exclusive'],
                              isLiked: articleList[index]['favorite'],
                              imagePath: articleList[index]['main_image_url'],
                              rating: articleList[index]['rating'],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 10.0,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
