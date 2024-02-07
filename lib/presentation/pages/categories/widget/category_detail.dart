import 'package:enxolist/infra/constants/categories_mapper.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/infra/utils/approuter.dart';
import 'package:flutter/material.dart';

class CategoryDetail extends StatelessWidget {
  final Category category;
  const CategoryDetail(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(AppRouter.CATEGORY_LIST, arguments: category.id),
      child: Container(
        color: ColorsTheme.primaryColorLight,
        child: category.icon,
      ),
    );
  }
}
