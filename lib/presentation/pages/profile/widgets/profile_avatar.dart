import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:enxolist/presentation/pages/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({Key? key}) : super(key: key);

  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  bool showListView =
      false; // Variável de estado para controlar a visibilidade do ListView.builder

  @override
  Widget build(BuildContext context) {
    final controller = getIt<ProfileController>();
    final Map<int, String> profileImages = {
      0: 'assets/imgs/avatares/1.jpg',
      1: 'assets/imgs/avatares/2.jpg',
      2: 'assets/imgs/avatares/3.jpg',
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(ThemeConstants.padding),
          child: Center(
            child: Stack(
              children: [
                Observer(builder: (context) {
                  return CircleAvatar(
                    backgroundImage: AssetImage(
                        profileImages[controller.selectedImageProfile]!),
                    radius: 100,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: const ShapeDecoration(
                          shape: LinearBorder(),
                          color: Color.fromARGB(144, 240, 236, 236),
                        ),
                        width: double.maxFinite,
                        height: 50,
                        child: Center(
                            child: IconButton(
                                isSelected: true,
                                onPressed: () {
                                  setState(() {
                                    showListView = !showListView;
                                  });
                                },
                                icon: const Icon(Icons.edit))),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        if (showListView) const SizedBox(height: 16),
        //
        AnimatedContainer(
          height: showListView ? 100 : 0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          child: Container(
            width: double.infinity,
            color: ColorsTheme.greyTransparent,
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: profileImages.length,
              itemBuilder: (ctx, i) {
                return GestureDetector(
                  onTap: () {
                    controller.changeSelectedImageProfile(i);
                    setState(() {
                      showListView = false;
                    });
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Image.asset(
                          profileImages[i]!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (showListView) const SizedBox(height: 16),
      ],
    );
  }
}
