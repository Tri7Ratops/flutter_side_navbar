import 'package:example/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_navbar/flutter_side_navbar.dart';

class Basic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: SideNavbar(
          navigationBackgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          pages: [
            SideItemModel(
              defaultIconColor: Colors.blue,
              onTap: () {},
              page: Column(
                children: [
                  Utils.backButton(context),
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
              iconTitle: "Home",
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
              iconTitle: "I don't know what I'm writing but here we are",
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
      ),
    );
  }
}
