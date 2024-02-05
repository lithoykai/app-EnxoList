import 'package:enxolist/infra/constants/categories_mapper.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:flutter/material.dart';

class CategoryDetail extends StatelessWidget {
  final Category category;
  const CategoryDetail(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 110,
      // width: 165,
      color: ColorsTheme.categoriesBackground,
      child: category.icon,
    );
  }
}
