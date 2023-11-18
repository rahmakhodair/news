import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/model/category.dart';
import 'package:news/tabs/tab_container.dart';

import '../model/SourceResponse.dart';

class CategoryDetails extends StatefulWidget {
  static const String routeName = 'category_details';
  Category category;

  CategoryDetails({required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse?>(
      future: ApiManager.getSources(widget.category.id),
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
              Text('Something went wrong'),
              ElevatedButton(
                  onPressed: () {
                    ApiManager.getSources(widget.category.id);
                    setState(() {});
                  },
                  child: Text('Try Again'))
            ],
          );
        }
        if (snapshot.data?.status != 'ok') {
          return Column(
            children: [
              Text(snapshot.data?.message ?? ''),
              ElevatedButton(onPressed: () {}, child: Text('Try Again'))
            ],
          );
        }
        var sourcesList = snapshot.data?.sources ?? [];
        return TabContainer(sourcesList: sourcesList);
      },
    );
  }
}
