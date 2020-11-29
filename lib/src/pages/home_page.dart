import 'package:flutter/material.dart';
import 'package:news/src/pages/news_tab_page.dart';
import 'package:news/src/pages/trends_tab_page.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //este provider notificara a todos los widgets hijos que hubo un cambio
    final nav = Provider.of<NavegacionModel>(context);
    
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: nav.navActual,
        onTap: (index) => nav.navActual = index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Para ti'),
          BottomNavigationBarItem(icon: Icon(Icons.public),label: 'Encabezados'),
        ],
      ),
      body: PageView(
        //esto es para que en android se mire el final pageview como en ios
        //physics: BouncingScrollPhysics(),
        physics: NeverScrollableScrollPhysics(),
        controller: nav.pageController,
        children:[
          NewsTabPage(),
          TrendsTabPage()
        ],
      ),
    );
  
  }
}

