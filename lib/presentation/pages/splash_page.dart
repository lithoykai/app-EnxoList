import 'package:enxolist/infra/utils/approuter.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool? onboardPage = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacementNamed(AppRouter.AUTH_OR_HOME);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 360,
        height: 800,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFFF0ECEC)),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: -263,
              child: Container(
                width: 415,
                height: 394,
                decoration: const ShapeDecoration(
                  color: Color(0x70FF9191),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: -230,
              top: -58,
              child: Container(
                width: 415,
                height: 394,
                decoration: const ShapeDecoration(
                  color: Color(0x70FF9191),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 235,
              top: 511,
              child: Container(
                width: 415,
                height: 394,
                decoration: const ShapeDecoration(
                  color: Color(0x70FF9191),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 5,
              top: 716,
              child: Container(
                width: 415,
                height: 394,
                decoration: const ShapeDecoration(
                  color: Color(0x70FF9191),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 238,
                    height: 220,
                    decoration: const BoxDecoration(
                      // color: Colors.black,
                      image: DecorationImage(
                        image: AssetImage("assets/imgs/icon.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'EnxoList',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 65,
                      fontFamily: 'JustMeAgainDownHere',
                      fontWeight: FontWeight.w400,
                      height: 0.03,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CircularProgressIndicator(
                    color: Colors.red[300],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
