import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:enxolist/infra/utils/store.dart';
import 'package:enxolist/presentation/pages/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProfileAvatar extends StatefulWidget {
  final void Function() showList;
  final UserResponse user;
  const ProfileAvatar({required this.user, required this.showList, Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  final controller = getIt<ProfileController>();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final imageIndex = await StoreData.getString('avatarIndex');
    if (imageIndex.isNotEmpty && imageIndex != '') {
      controller.changeSelectedImageProfile(int.tryParse(imageIndex) ?? 0);
    }
  }

  bool showListView = false;

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).size.width > 600;
    final Map<int, String> profileImages = {
      0: 'assets/imgs/avatares/av1.png',
      1: 'assets/imgs/avatares/av2.png',
      2: 'assets/imgs/avatares/av3.png',
      3: 'assets/imgs/avatares/av4.png',
      4: 'assets/imgs/avatares/av5.png',
      5: 'assets/imgs/avatares/av6.png',
      6: 'assets/imgs/avatares/av7.png',
      7: 'assets/imgs/avatares/av8.png',
      8: 'assets/imgs/avatares/av9.png',
      9: 'assets/imgs/avatares/av10.png',
    };

    return isLandscape
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(ThemeConstants.padding),
                        child: Center(
                          child: Stack(
                            children: [
                              Observer(builder: (context) {
                                return CircleAvatar(
                                  backgroundImage: AssetImage(profileImages[
                                      controller.selectedImageProfile]!),
                                  radius: 52,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      decoration: const ShapeDecoration(
                                          shape: LinearBorder(),
                                          color:
                                              Color.fromARGB(87, 75, 73, 73)),
                                      width: double.maxFinite,
                                      height: 50,
                                      child: Center(
                                          child: IconButton(
                                              isSelected: true,
                                              onPressed: () {
                                                setState(() {
                                                  widget.showList();
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
                    ],
                  ),
                  Text(
                    widget.user.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              AnimatedContainer(
                height: showListView ? 65 : 0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: profileImages.length,
                  itemBuilder: (ctx, i) {
                    return GestureDetector(
                      onTap: () {
                        controller.changeSelectedImageProfile(i);
                        setState(() {
                          widget.showList();
                          showListView = false;
                        });
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 50,
                            width: 50,
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
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                              decoration: ShapeDecoration(
                                shape: const LinearBorder(),
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withAlpha(150),
                              ),
                              width: double.maxFinite,
                              height: 50,
                              child: Center(
                                  child: IconButton(
                                      isSelected: true,
                                      onPressed: () {
                                        setState(() {
                                          widget.showList();
                                          showListView = !showListView;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ))),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                height: showListView ? 100 : 0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: Container(
                  width: double.infinity,
                  color: Theme.of(context).cardColor,
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: profileImages.length,
                    itemBuilder: (ctx, i) {
                      return GestureDetector(
                        onTap: () {
                          controller.changeSelectedImageProfile(i);
                          setState(() {
                            widget.showList();
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
              const SizedBox(
                height: 5,
              ),
              Text(widget.user.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge),
            ],
          );
  }
}
