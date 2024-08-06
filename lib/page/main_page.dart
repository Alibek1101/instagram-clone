import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/page/profile_page.dart';
import 'package:untitled/page/search_page.dart';

import 'favorite_page.dart';
import 'home_page.dart';
import 'myfeed_page.dart';

class Home_page extends StatefulWidget {
  static final String id = "Home_Page";

  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  PageController? _pageController;
  int _currentTap = 4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          MyHomePage(
            pageController: PageController(),
          ),
          MySearchPage(
            pageController: PageController(),
          ),
          MyFeedPage(page: _pageController,),
          MyFaviritePage(
              pageController: PageController()),
          MyProfilePage(),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTap = index;
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.grey,
        color: Colors.grey,
        animationDuration: Duration(microseconds: 300),
        items: [
          Icon(
            Icons.home,
            size: 26,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
            size: 26,
            color: Colors.white,
          ),
          Icon(
            Icons.add,
            size: 26,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
            size: 26,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 26,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentTap = index;
            _pageController!.animateToPage(index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInSine);
          });
        },
      ),
    );
  }
}