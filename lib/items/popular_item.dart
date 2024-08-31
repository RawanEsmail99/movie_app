import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/components.dart';
import 'package:movie_app/screens/details_screen.dart';

import '../API_MANAGER.dart';

class PopularItem extends StatelessWidget {
  const PopularItem({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getPopular(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        var popular = snapshot.data?.results ?? [];

        return CarouselSlider(
          options: CarouselOptions(
              height: 400,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1.0),
          items: popular.map((item) =>
              
              Stack(
                    children: [
                      Container(
                        height: 400,
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () {
                          navigateTo(context, DetailsScreen(id: item.id!.toInt(), name: item.title??''));
                        },
                        child: CachedNetworkImage(
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.fill,
                          imageUrl:
                              "https://image.tmdb.org/t/p/w92${item.backdropPath ?? ''}",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 15,
                        child: CachedNetworkImage(
                          width: 120,
                          height: 200,
                          fit: BoxFit.fill,
                          colorBlendMode: BlendMode.multiply,
                          imageUrl:
                              "https://image.tmdb.org/t/p/w92${item.posterPath ?? ''}",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        left: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title ?? '',
                              style: GoogleFonts.elMessiri(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            Text(
                              item.releaseDate ?? '',
                              style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
              .toList(),
        );
      },
    );
  }
}
