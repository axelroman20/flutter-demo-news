import 'package:flutter/material.dart';
import 'package:flutter_provider/src/models/category_model.dart';
import 'package:flutter_provider/src/services/news_service.dart';
import 'package:flutter_provider/src/theme/theme.dart';
import 'package:flutter_provider/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListaCategorias(),
            Expanded(
              child: ListaNoticias(
                newsService.getArticulosCategoriaSeleccionada!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return SizedBox(
      height: 80,
      width: double.infinity,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cName = categories[index].name;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _CategoryButton(categories[index]),
                const SizedBox(height: 5),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;
  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewsService>(context, listen: false);

    return GestureDetector(
      onTap: () {
        newService.selectedGategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(category.icon,
            color: (newService.selectedGategory == category.name)
                ? myTheme.colorScheme.secondary
                : Colors.black54),
      ),
    );
  }
}
