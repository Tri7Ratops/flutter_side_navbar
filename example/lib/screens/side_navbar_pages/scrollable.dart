import 'package:example/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_navbar/flutter_side_navbar.dart';

class ScrollableSideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Utils.backButton(context),
              Utils.getContainer(height: 300, color: Colors.yellow),
              SideNavbar(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                navigationBackgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                pages: [
                  SideItemModel(
                    defaultIconColor: Colors.blue,
                    onTap: () {},
                    page: Column(
                      children: [
                        Utils.getContainer(
                          height: 100,
                          color: Colors.red,
                        ),
                        Utils.getContainer(
                          height: 300,
                          color: Colors.red,
                        ),
                        Utils.getContainer(
                          height: 100,
                          color: Colors.red,
                        ),
                        Utils.getContainer(
                          height: 50,
                          color: Colors.red,
                        ),
                        Utils.getContainer(
                          height: 200,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    icon: Icons.home_filled,
                  ),
                  SideItemModel(
                    defaultIconColor: Colors.blue,
                    onTap: () {},
                    page: Column(
                      children: [
                        Utils.getContainer(
                          height: 400,
                          color: Colors.green,
                        ),
                        Utils.getContainer(
                          height: 100,
                          color: Colors.green,
                        ),
                        Utils.getContainer(
                          height: 200,
                          color: Colors.green,
                        ),
                        Utils.getContainer(
                          height: 100,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    icon: Icons.verified_user,
                  ),
                  SideItemModel(
                    defaultIconColor: Colors.blue,
                    onTap: () {},
                    page: Column(
                      children: [
                        Utils.getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                        Utils.getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                        Utils.getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                        Utils.getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                        Utils.getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                      ],
                    ),
                    icon: Icons.lock_clock,
                  ),
                ],
              ),
              Utils.getContainer(height: 300, color: Colors.lightGreen),
            ],
          ),
        ),
      ),
    );
  }
}
