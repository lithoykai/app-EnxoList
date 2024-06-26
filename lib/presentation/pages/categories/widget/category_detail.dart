import 'package:enxolist/infra/constants/categories_mapper.dart';
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
        width: MediaQuery.of(context).size.width * 0.5,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            // shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            category.icon,
            const SizedBox(
              height: 2,
            ),
            Text(
              category.title,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}
