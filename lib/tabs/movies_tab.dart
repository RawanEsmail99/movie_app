import 'package:flutter/material.dart';

import '../items/popular_item.dart';
import '../items/recommended_item.dart';
import '../items/release_item.dart';

class MoviesTab extends StatelessWidget {
  const MoviesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: [
        PopularItem(),
        SizedBox(
          height: 20,
        ),
        Release(),
        SizedBox(
          height: 20,
        ),
        RecommendedItem(),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
