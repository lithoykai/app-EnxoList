import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class ListInfoWidget extends StatefulWidget {
  const ListInfoWidget({super.key});

  @override
  State<ListInfoWidget> createState() => _ListInfoWidgetState();
}

class _ListInfoWidgetState extends State<ListInfoWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controllerAnimation = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controllerAnimation,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Column(
        children: [
          Expanded(
            flex: 45,
            child: Padding(
              padding: const EdgeInsets.all(ThemeConstants.doublePadding),
              child: Image.asset('assets/imgs/onboard/list.png'),
            ),
          ),
          Expanded(
            flex: 35,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: ThemeConstants.halfPadding,
                    horizontal: ThemeConstants.doublePadding),
                child: Column(
                  children: [
                    Text(
                      'Crie sua lista',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      ' Aproveite a praticidade de categorizar suas compras de acordo com as diferentes partes da casa, como cozinha, banheiro, quarto, e muito mais. Isso facilita encontrar os itens que você precisa, garantindo uma experiência de compra mais organizada e eficiente.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
