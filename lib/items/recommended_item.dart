import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/components.dart';
import 'package:movie_app/screens/details_screen.dart';

import '../API_MANAGER.dart';
import '../firebase/firestore.dart';

class RecommendedItem extends StatelessWidget {
  const RecommendedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      color: Color(0xFF343534),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recomended',
              style: GoogleFonts.elMessiri(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: ApiManager.getRecommended(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error');
                }

                var recommended = snapshot.data?.results ?? [];
                return Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            navigateTo(context, DetailsScreen(
                              id: recommended[index].id??0,
                              name: recommended[index].title??'',
                            ));
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.height * 0.2,
                              height: MediaQuery.of(context).size.height*0.4,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: const Color(0xFF282a28),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${recommended[index].posterPath}',
                                          height: 200,
                                          width: double.infinity,
                                          fit: BoxFit.cover),
                                      Container(
                                        height: 36,
                                        width: 27,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/icon_add.png'),
                                                fit: BoxFit.cover)),
                                        child: Center(
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              addMovie(
                                                poster: 'https://image.tmdb.org/t/p/w500${recommended[index].posterPath}',
                                                title: '${recommended[index].title}',
                                                date: '${recommended[index].releaseDate}',
                                                id: recommended[index].id!.toInt(),
                                                context: context,
                                              );
                                            },
                                            icon: Icon(Icons.add),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              recommended[index]
                                                  .voteAverage
                                                  .toString()
                                                  .substring(0, 3),
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${recommended[index].title}',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${recommended[index].releaseDate}',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        SizedBox(height: 5,),

                                        Text(
                                          '${recommended[index].originalLanguage}',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 12,
                          ),
                      itemCount: recommended.length),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
