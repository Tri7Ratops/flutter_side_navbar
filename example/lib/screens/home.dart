import 'package:flutter/material.dart';

import 'side_navbar_pages/side_navbar_pages.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _getButton(
                title: "Basic",
                color: Colors.orangeAccent,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Basic()),
                ),
              ),
              _getButton(
                  title: "Basic reversed",
                color: Colors.redAccent,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BasicReversed()),
                ),
              ),
              _getButton(
                title: "Basic with AppBar",
                color: Colors.greenAccent,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BasicWithAppbar()),
                ),
              ),
              _getButton(
                title: "Scrollable",
                color: Colors.purpleAccent,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScrollableSideBar()),
                ),
              ),
              _getButton(
                title: "Scrollable with AppBar",
                color: Colors.blueAccent,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScrollableWithAppbar()),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _getButton({required String title, required Color color, required Function() onPressed}) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(10))),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Text(
          title.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
