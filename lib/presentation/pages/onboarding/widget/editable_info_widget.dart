import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class EditableInfoWidget extends StatefulWidget {
  const EditableInfoWidget({super.key});

  @override
  State<EditableInfoWidget> createState() => _EditableInfoWidgetState();
}

class _EditableInfoWidgetState extends State<EditableInfoWidget>
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

  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Column(
        children: [
          Expanded(
            flex: 45,
            child: Padding(
              padding: const EdgeInsets.all(ThemeConstants.doublePadding),
              child: Image.asset('assets/imgs/onboard/editable.png'),
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
                      'Gerencie seus itens',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Marque os itens como concluídos à medida que você os adquire. Com isso, visualize o valor total das suas compras para manter o controle do seu orçamento e gerenciar seus gastos de forma eficaz, garantindo que estejam dentro do planejado.\n\n Que tal testar na prática?',
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
