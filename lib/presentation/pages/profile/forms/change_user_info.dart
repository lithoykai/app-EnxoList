import 'package:flutter/material.dart';

class ChangeUserInfo extends StatelessWidget {
  const ChangeUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar informações de usuário'),
      ),
      body: const Center(child: Text('Alterar')),
    );
  }
}
