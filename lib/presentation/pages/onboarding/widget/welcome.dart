import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
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
              child: Image.asset('assets/imgs/onboard/welcome.png'),
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
                      'Bem-vindo',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'O Enxolist foi projetado para simplificar a sua experiência de preparar o enxoval para sua nova casa.\n\nCrie e gerencie listas de compras com facilidade para garantir que você tenha tudo o que precisa.',
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
