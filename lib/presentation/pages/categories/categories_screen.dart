import 'package:enxolist/infra/constants/categories_mapper.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:enxolist/presentation/pages/categories/widget/category_detail.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: MediaQuery.of(context).size.width > 600 ? 32 : 15,
              child: const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ThemeConstants.doublePadding,
                    vertical: ThemeConstants.padding),
                child: Text(
                  'Categorias',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 95,
              child: Scrollbar(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
