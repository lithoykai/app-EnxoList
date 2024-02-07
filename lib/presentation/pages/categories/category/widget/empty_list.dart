import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:enxolist/infra/utils/approuter.dart';
import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(ThemeConstants.doublePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 320,
                child: Image.asset('assets/imgs/undraw/nodata.png')),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Não há nenhum item adicionado nesta categoria.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(
                AppRouter.PRODUCT_FORM_PAGE,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsTheme.primaryColor,
                foregroundColor: ColorsTheme.primaryColorLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'ADICIONAR PRODUTO',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
