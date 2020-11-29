import 'package:flutter/material.dart';
import 'package:news/src/services/news_service.dart';
import 'package:news/src/widgets/list_news.dart';
import 'package:provider/provider.dart';


class NewsTabPage extends StatefulWidget{
  @override
  _NewsTabPageState createState() => _NewsTabPageState();
}
//AutomaticKeepAliveClientMixin me sirve para conservar el estado de la aplicacion
//si muevo el scroll o hago alguna otra cosa, al regresar a este widget se conserva su estado
class _NewsTabPageState extends State<NewsTabPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<NewsService>(context);
    return Scaffold(
      body: ListNews(noticias: nav.headlines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}