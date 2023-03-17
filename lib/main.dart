import 'package:flutter/material.dart';
import 'package:news_feed/view/style/style.dart';
import 'package:news_feed/viewmodel/head_line_viewmodel.dart';
import 'package:news_feed/viewmodel/news_list_viewmodel.dart';
import 'package:provider/provider.dart';
import 'view/screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsListViewModel()),
        ChangeNotifierProvider(create: (_) => HeadLineViewModel()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NewsFeed",
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: BlackFont,
      ),
      home: HomeScreen(),
    );
  }
}
