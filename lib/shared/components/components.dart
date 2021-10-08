import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/modules/webview/webview_screen.dart';

Widget buildArticleItem(dynamic item,context) {
  String urlImage=item['urlToImage']??'https://i.stack.imgur.com/y9DpT.jpg';
  return
    InkWell(
      onTap: ()
      {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder:(context) =>WebViewScreen(url: item['url'],) ));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Container(
          height: 120,
          width: 120,
          decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(urlImage)
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      Expanded(
              flex:1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${item['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${item['publishedAt']}',
                    style: TextStyle(
                        fontSize: 12,
                       color: Colors.grey

                    ),
                  ),
                ],
              ),
            ),

  ]),
      ),
    );
}
Widget articleBuilder(dynamic list,context)
{
  return ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context)=>ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index)=>buildArticleItem(list[index],context),
        separatorBuilder: (context,index)=>Container(height: 1,),
        itemCount: 10),
    fallback: (context)=>Center(child: CircularProgressIndicator(),),
  );
}
//flutter run --no-sound-null-safety