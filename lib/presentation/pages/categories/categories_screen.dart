import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/infra/constants/categories_mapper.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:enxolist/presentation/pages/categories/controller/categories_controller.dart';
import 'package:enxolist/presentation/pages/categories/widget/category_detail.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final controller = getIt<CategoriesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme.background,
      body: Container(
        color: ColorsTheme.background,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(ThemeConstants.doublePadding),
                child: Text(
                  'Categorias',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
              Expanded(
                child: GridView(
                  padding: const EdgeInsets.all(25),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  children: CATEGORIES.map((cat) {
                    return CategoryDetail(cat);
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
