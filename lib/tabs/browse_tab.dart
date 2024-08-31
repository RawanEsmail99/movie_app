import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/API_MANAGER.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/components.dart';
import 'package:movie_app/items/movie_browse.dart';
import 'package:movie_app/models/movie_genre_list.dart';

class Browse extends StatefulWidget {
  const Browse({super.key});

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      body: Center(
        child: FutureBuilder(
            future: ApiManager.fetchGenres(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 3,
                  ),
                  itemBuilder: (context, index) {
                    return EasyContainer(
                        color: Colors.transparent,
                        showBorder: true,
                        borderColor: Colors.white,
                        borderRadius: 20,
                        borderWidth: 1,
                        onTap: () {
                          navigateTo(
                              context,
                              MovieBrowse(
                                name: snapshot.data!.genres[index].name,
                                genreIds: [snapshot.data!.genres[index].id],
                              ));
                        },
                        child: Center(
                          child: Text(
                            snapshot.data!.genres[index].name,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ));
                  },
                  itemCount: snapshot.data!.genres.length,
                );
              } else {
                return const Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                );
              }
            }),
      ),
    );
  }
}
