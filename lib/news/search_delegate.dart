import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/my_theme.dart';
import 'package:news/news/news_item.dart';

import '../model/NewsResponse.dart';

class NewsSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => showResults(context),
          icon: Icon(
            Icons.search,
            size: 30,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.close,
          size: 30,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      return FutureBuilder<NewsResponse?>(
          future: ApiManager.searchNews(query ?? ""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  const Text('Something went wrong'),
                  ElevatedButton(
                    onPressed: () {
                      ApiManager.searchNews(query ?? '');
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              );
            }

            /// server
            if (snapshot.data?.status != 'ok') {
              return Column(
                children: [
                  Text(snapshot.data?.message ?? ""),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Try Again'),
                  ),
                ],
              );
            }
            var newsList = snapshot.data?.articles ?? [];
            return ListView.builder(
              itemBuilder: (context, index) {
                return NewsItem(news: newsList[index]);
              },
              itemCount: newsList.length,
            );
          });
    } else {
      return Container();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: MyTheme.primaryLightColor,
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderSide: BorderSide.none)),
      appBarTheme: AppBarTheme(
        backgroundColor: MyTheme.primaryLightColor,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: MyTheme.whiteColor,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyTheme.blackColor,
          )),
    );
  }
}
