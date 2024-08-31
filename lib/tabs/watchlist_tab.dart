import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/screens/details_screen.dart';

import '../components.dart';
import '../models/watch_list.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> movies =
        FirebaseFirestore.instance.collection('movies').snapshots();
    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        backgroundColor: Constants.background,
        title: const Text(
          'Watch List',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: movies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<WatchList> watchList = [];
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                watchList.add(WatchList.fromJson(snapshot.data!.docs[i]));
              }
              return watchList.isEmpty
                  ? const Center(
                      child: Text(
                        'Add movies to your Watch List',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: watchList.length,
                          itemBuilder: (context, index) {
                            return EasyContainer(
                              padding: 8,
                              color: Colors.transparent,
                              showBorder: true,
                              borderWidth: 1,
                              borderColor: Colors.white,
                              borderRadius: 12,
                              onTap: () {
                                navigateTo(
                                    context,
                                    DetailsScreen(
                                        name: watchList[index].title,
                                        id: watchList[index].id));
                              },
                              child: ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500${watchList[index].poster}',
                                ),
                                title: Text(
                                  watchList[index].title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  watchList[index].date,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Data Error from data base',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text(
                  'Error',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              );
            }
          }),
    );
  }
}
