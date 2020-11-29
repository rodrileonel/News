
import 'package:flutter/material.dart';
import 'package:news/src/models/news_model.dart';
import 'package:news/src/theme/theme.dart';

class ListNews extends StatelessWidget {

  final List<Article> noticias;

  const ListNews({@required this.noticias});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _New(article: this.noticias[index],index: index,);
      },
    );
  }
}

class _New extends StatelessWidget {

  final Article article;
  final int index;

  const _New({@required this.article,@required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(article,index),
        thenew(article),
        image(article),
        description(article),
        buttons(),
        Divider(),
      ],
    );
  }

  Widget header(Article article,int index) => Container(
    margin: EdgeInsets.symmetric(horizontal:5),
    child: Row(
      children:[
        Text('${index +1} ', style: TextStyle(color: theme.accentColor),),
        Text('${article.source.name}', style: TextStyle(color: theme.accentColor),),
      ]
    ),
  );

  Widget thenew(Article acticle) => Container(
    margin: EdgeInsets.all(10),
    child: Text(article.title, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
  );

  Widget image(Article article) => Container(
    margin: EdgeInsets.all(10),
    child: ClipRRect(
      borderRadius: BorderRadius.only(bottomRight:Radius.circular(20),topLeft: Radius.circular(20)),
      child: (article.urlToImage!=null)
        ? FadeInImage(
          placeholder: AssetImage('assets/giphy.gif'),
          image: NetworkImage(article.urlToImage),
        ): Image(image: AssetImage('assets/no-image.png'),) ,
    ),
  );

  Widget description(Article article) => Container(
    margin: EdgeInsets.all(10),
    child: (article.description != null) ? Text(article.description):Text(''),
  );

  Widget buttons() => Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        RawMaterialButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: theme.accentColor,
          child: Icon(Icons.favorite),
        ),
        SizedBox(width:30),
        RawMaterialButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.blue,
          child: Icon(Icons.more),
        ),
      ]
    ),
  );
}