import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FieldPlaceHoler extends StatelessWidget {
  const FieldPlaceHoler({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 10.0,
              width: 200.0,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ),
      baseColor: Color(0xffbbbbbb),
      highlightColor: Color(0xffdddddd),
    );
  }
}
