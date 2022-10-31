import 'package:flutter/material.dart';
import 'package:flutter_provider/src/pages/tab1_page.dart';
import 'package:flutter_provider/src/pages/tab2_page.dart';
import 'package:flutter_provider/src/theme/theme.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navigacionModel.paginaActual,
      onTap: (i) => navigacionModel.paginaActual = i,
      selectedItemColor: myTheme.colorScheme.secondary,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Para ti',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Encabezados',
        ),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaAxtual = 0;
  final PageController _pageController = PageController();

  int get paginaActual => _paginaAxtual;
  PageController get pageController => _pageController;

  set paginaActual(int valor) {
    _paginaAxtual = valor;
    _pageController.animateToPage(valor,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }
}
