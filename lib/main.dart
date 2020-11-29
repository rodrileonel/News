import 'package:flutter/material.dart';
import 'package:news/src/pages/home_page.dart';
import 'package:news/src/services/news_service.dart';
import 'package:news/src/theme/theme.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'Material App',
      home: MultiProvider(
        //podria usar muchos providers
        providers: [
          ChangeNotifierProvider(create: (_) => NavegacionModel(),),
          ChangeNotifierProvider(create: (_) => NewsService(),),
        ],
        child: HomePage()
      )
    );
  }
}

class NavegacionModel with ChangeNotifier{
  int _navActual =0;
  PageController _pageController = PageController();

  PageController get pageController => this._pageController;

  get navActual => this._navActual;
  set navActual(int value){
    this._navActual = value;
    _pageController.animateToPage(value, duration: Duration(milliseconds:250), curve: Curves.easeOut);
    //esto avisa a los widgets que esten usando navActual que ha sido cambiado
    notifyListeners();
  }
}