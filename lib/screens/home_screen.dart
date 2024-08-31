import 'package:flutter/material.dart';
import 'package:movie_app/tabs/browse_tab.dart';
import 'package:movie_app/tabs/movies_tab.dart';
import 'package:movie_app/tabs/search_tab.dart';
import 'package:movie_app/tabs/watchlist_tab.dart';

import '../models/watch_list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [MoviesTab(), Search(), Browse(), WishList()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xFF1A1A1A),
            unselectedItemColor: Color(0xFFC6C6C6),
            selectedItemColor: Color(0xFFFFB224),
            currentIndex: selectedIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              selectedIndex = value;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.movie_creation), label: 'Browse'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'WatchList'),
            ],
          ),
          body: tabs[selectedIndex]),
    );
  }
}
