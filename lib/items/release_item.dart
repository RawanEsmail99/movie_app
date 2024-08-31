import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/components.dart';
import 'package:movie_app/screens/details_screen.dart';

import '../API_MANAGER.dart';
import '../firebase/firestore.dart';

class Release extends StatelessWidget {
  const Release({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF343534),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New Releases',
            style: GoogleFonts.elMessiri(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 200,
            child: Expanded(
              child: FutureBuilder(
                future: ApiManager.getReleases(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Error');
                  }

                  var releases = snapshot.data?.results ?? [];
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 20,
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            navigateTo(context, DetailsScreen(id: releases[index].id!.toInt(), name: releases[index].title??''));
                          },
                          child: Stack(
                            children: [
                              Image.network(
                                  "https://image.tmdb.org/t/p/w92${releases[index].posterPath ?? ''}",
                                  width: 120,
                                  height: 180,
                                  fit: BoxFit.fitWidth,
                                  colorBlendMode: BlendMode.multiply),
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
                                        poster: 'https://image.tmdb.org/t/p/w500${releases[index].posterPath}',
                                        title: '${releases[index].title}',
                                        date: '${releases[index].releaseDate}',
                                        id: releases[index].id!.toInt(),
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
                        );
                      },
                      itemCount: releases.length,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
