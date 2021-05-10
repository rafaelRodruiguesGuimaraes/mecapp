import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    Key key,
    this.isExclusive,
    this.isLiked,
    this.imagePath,
    this.title,
    this.subTitle,
    this.setIsLiked, this.rating,
  }) : super(key: key);

  final bool isExclusive;
  final bool isLiked;
  final Function setIsLiked;
  final String imagePath;
  final String title;
  final String subTitle;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isExclusive ? 0.3 : 1,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(imagePath),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Color(0xffeeeeee)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: setIsLiked,
                        child: Icon(
                          Icons.favorite,
                          color: isLiked ? Colors.red : Colors.black12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                      color: Color(0xff474747),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {},
                      starCount: 5,
                      rating: rating,
                      size: 25.0,
                      isReadOnly: true,
                      color: Color(0xfffec107),
                      borderColor: Color(0xfffec107),
                      spacing: 0.0)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }
}
