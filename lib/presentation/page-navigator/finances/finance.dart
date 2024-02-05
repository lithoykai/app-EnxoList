import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:flutter/material.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsTheme.background,
      child: SafeArea(
          child: Center(
        child: Text('Páginas de finanças'),
      )),
    );
  }
}
