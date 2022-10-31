import 'package:flutter/material.dart';
import 'package:flutter_provider/src/pages/tabs_page.dart';
import 'package:flutter_provider/src/services/news_service.dart';
import 'package:flutter_provider/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo News',
        theme: myTheme,
        initialRoute: 'home',
        home: const TabsPage(),
      ),
    );
  }
}
