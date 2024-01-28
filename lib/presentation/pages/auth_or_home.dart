import 'package:enxolist/data/services/auth_service.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/presentation/pages/auth_page.dart';
import 'package:enxolist/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    AuthService auth = getIt<AuthService>();

    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          return Observer(builder: (context) {
            return auth.isAuth ? HomePage() : AuthPage();
          });
        }
      },
    );
  }
}

// class AuthOrHomePage extends StatelessWidget {
//   const AuthOrHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     AuthService auth = getIt<AuthService>();

//     autorun((_) {
//       if (auth.isAuth) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (_) => HomePage()),
//         );
//       }
//     });
//     return FutureBuilder(
//       future: auth.tryAutoLogin(),
//       builder: (ctx, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (snapshot.error != null) {
//           return const Center(
//             child: Text('Ocorreu um erro!'),
//           );
//         } else {
//           return Observer(
//               builder: (_) => auth.isAuth ? HomePage() : AuthPage());
//         }
//       },
//     );
//   }
// }
