import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/API_MANAGER.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/items/details_item.dart';
import '../components.dart';

class DetailsScreen extends StatefulWidget {
  int id;
  String name;

  DetailsScreen({required this.id, required this.name, super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        backgroundColor: Constants.background,
        title: Text(
          widget.name,
          style: GoogleFonts.aBeeZee(fontSize: 22, color: Colors.white),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Column(
        children: [
          DetailsItem(id: widget.id),
          Container(
            height: MediaQuery.of(context).size.height * 0.29,
            color: Colors.black26,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'More Like This',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: ApiManager.fetchSimilarMovies(widget.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final movie = snapshot.data![index];
                                return GestureDetector(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        DetailsScreen(
                                          name: '${movie['original_title']},',
                                          id: movie['id'],
                                        ));
                                  },
                                  child: Container(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff343534),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                                height: 90,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                              Container(
                                                height: 60,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                        'assets/images/icon_add.png',
                                                      ),
                                                      fit: BoxFit.cover),
                                                ),
                                                child: IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${movie['original_title']}',
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
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
                                                      '${movie['vote_average']}',
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${movie['release_date']}',
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 12,
                                  ),
                              itemCount: snapshot.data!.length);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
