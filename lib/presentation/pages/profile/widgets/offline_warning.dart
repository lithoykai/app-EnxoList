import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:enxolist/infra/utils/approuter.dart';
import 'package:flutter/material.dart';

class OfflineWarning extends StatelessWidget {
  const OfflineWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(ThemeConstants.doublePadding),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSecondary),
                text:
                    'Você não está conectado a nenhuma conta. Alguns recursos, como a  ',
                children: [
                  TextSpan(
                      text: 'sincronização de dados ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSecondary)),
                  const TextSpan(
                    text:
                        'não irão funcionar. Por favor, conecte-se a uma conta para ter acesso a todos os recursos.',
                  ),
                ],
              )),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.AUTH_PAGE);
            },
            child: const Text(
              'Conectar-se',
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}
