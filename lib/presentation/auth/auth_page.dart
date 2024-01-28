import 'package:enxolist/presentation/auth/widget/auth_form.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  bool toggleLogin() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          isLogin = !isLogin;
        });
      }
    });

    return isLogin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0ECEC),
      body: Column(
        children: [
          Stack(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              height: isLogin
                  ? MediaQuery.sizeOf(context).height * 0.4
                  : MediaQuery.sizeOf(context).height * 0.32,
              decoration: BoxDecoration(
                // border: Border.all(),
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  scale: isLogin ? 1.4 : 1.8,
                  alignment: Alignment.bottomRight,
                  image: const AssetImage("assets/imgs/login_image.png"),
                  fit: BoxFit.scaleDown,
                ),
                gradient: const LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0x60FFB8B8), Color(0xFFFFB8B8)],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                  vertical: isLogin
                      ? MediaQuery.sizeOf(context).height * 0.09
                      : MediaQuery.sizeOf(context).height * 0.02,
                  horizontal: MediaQuery.sizeOf(context).width * 0.09,
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: isLogin
                      ? MediaQuery.sizeOf(context).height * 0.25
                      : MediaQuery.sizeOf(context).height * 0.32,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.centerLeft,
                      image: AssetImage("assets/imgs/text_auth.png"),
                    ),
                  ),
                )),
          ]),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: AuthForm(
                toggleLogin: toggleLogin,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
