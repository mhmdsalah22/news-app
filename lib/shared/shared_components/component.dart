import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view_screen.dart';

Widget buildItem(Map business, context) => InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewScreen(business['url'])));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('${business['urlToImage']}'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${business['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${business['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(List list, {bool isSearch = false}) => list.isEmpty
    ? isSearch
        ? Container()
        : const Center(child: CircularProgressIndicator())
    : ListView.separated(
        //shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildItem(list[index], context),
        separatorBuilder: (context, index) => Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey[100],
        ),
        itemCount: list.length,
      );
