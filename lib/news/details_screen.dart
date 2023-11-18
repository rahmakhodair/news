import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/model/NewsResponse.dart';
import 'package:news/my_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = 'details screen';

  @override
  Widget build(BuildContext context) {
    var news = ModalRoute.of(context)?.settings.arguments as News;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: news.urlToImage ?? "",
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              news.author ?? "",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: MyTheme.grayColor,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              news.content ?? "",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              news.publishedAt ?? "",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: MyTheme.grayColor,
                  ),
              textAlign: TextAlign.end,
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () => _launchUrl(news.url!),
              child: Row(
                children: [
                  Text('View full article'),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    var uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
