import 'package:flutter/material.dart';
import 'package:flutter_side_navbar/flutter_side_navbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text("Home PAGE"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _getContainer(height: 400, color: Colors.green, margeVertical: 0),
              SideNavbar(
                reversed: true,
                navigationBackgroundColor: Colors.black,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                pages: [
                  SideItemModel(
                    defaultIconColor: Colors.blue,
                    onTap: () {},
                    page: Column(
                      children: [
                        _getContainer(
                          height: 100,
                          color: Colors.red,
                        ),
                        _getContainer(
                          height: 300,
                          color: Colors.red,
                        ),
                        _getContainer(
                          height: 100,
                          color: Colors.red,
                        ),
                        _getContainer(
                          height: 50,
                          color: Colors.red,
                        ),
                        _getContainer(
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
                        _getContainer(
                          height: 400,
                          color: Colors.green,
                        ),
                        _getContainer(
                          height: 100,
                          color: Colors.green,
                        ),
                        _getContainer(
                          height: 200,
                          color: Colors.green,
                        ),
                        _getContainer(
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
                        _getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                        _getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                        _getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                        _getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                        _getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                      ],
                    ),
                    icon: Icons.lock_clock,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getContainer({required double height, required Color color, double margeVertical = 10.0}) {
    return Container(
      height: height,
      width: double.infinity,
      color: color,
      margin: EdgeInsets.only(bottom: margeVertical),
    );
  }
}
