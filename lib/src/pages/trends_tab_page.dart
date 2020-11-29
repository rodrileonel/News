import 'package:flutter/material.dart';
import 'package:news/src/models/categories_model.dart';
import 'package:news/src/models/news_model.dart';
import 'package:news/src/services/news_service.dart';
import 'package:news/src/widgets/list_news.dart';
import 'package:provider/provider.dart';


class TrendsTabPage extends StatefulWidget {

  @override
  _TrendsTabPageState createState() => _TrendsTabPageState();
}

class _TrendsTabPageState extends State<TrendsTabPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    final news = Provider.of<NewsService>(context);
    final _screen = MediaQuery.of(context).size;
    news.getArticlesByCategory(news.selectedCateg);
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _categories(news.categories,_screen.height*0.15),
          _listNews(news.getArticlesBySelectedCategory,context),
        ],
      ),
    );
  }

  Widget _listNews(List<Article> news,BuildContext context) {
    return Expanded(
      child: Container(
        child: (news.isNotEmpty)
              ?ListNews(noticias: news)
              :Center(child: CircularProgressIndicator())
      ),
    );
  }

  Widget _categories(List<Category> categories, double height) => Container(
    height: height,
    child: ListView.builder(
      itemCount: categories.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context,int index){
        final categorieNews = Provider.of<NewsService>(context);
        return GestureDetector(
          onTap: () {
            //en el evento tab debe ir listen=false para que no se redibuje
            //final categorieNews = Provider.of<NewsService>(context,listen: false);
            categorieNews.selectedCateg = categories[index].name;
          },
          child: Container(
            height: height,
            padding: EdgeInsets.all(10),
            child: Column(
              children:[
                _icon(categories, index, categorieNews.selectedCateg),
                SizedBox(height:5),
                Text(
                  '${categories[index].name[0].toUpperCase()}${categories[index].name.substring(1)}',
                  style: (categorieNews.selectedCateg==categories[index].name) ? TextStyle(color: Colors.orange):TextStyle(color: Colors.white),
                ),
              ]
            ),
          ),
        );
      }
    ),
  );

  Widget _icon(List<Category> categories, int index, String selected) {
    return Container(
      width: 45,
      height: 45,
      margin: EdgeInsets.symmetric(horizontal:20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white
      ),
      child: Icon(categories[index].icon,color: (categories[index].name == selected) ? Colors.orange:Colors.black,)
    );
  }

  @override
  bool get wantKeepAlive => true;
}