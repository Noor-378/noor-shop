import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:hidable/hidable.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    AdvancedDrawerController advancedDrawer = AdvancedDrawerController();
    return AdvancedDrawer(
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      backdropColor: Colors.blue,
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 0.0),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      controller: advancedDrawer,
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(top: 24.0, bottom: 64.0),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 30,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.home),
                title: const Text('Home'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.account_circle_rounded),
                title: const Text('Profile'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.favorite),
                title: const Text('Favourites'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
              ),
              const Spacer(),
              const DefaultTextStyle(
                style: TextStyle(fontSize: 12, color: Colors.white54),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text("data")),
        body: ListView(
          controller: scrollController,
          children: [
            Container(height: 100, width: double.infinity, color: Colors.amber),
            Container(height: 100, width: double.infinity, color: Colors.red),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.deepOrange,
            ),
            Container(height: 100, width: double.infinity, color: Colors.green),
            Container(height: 100, width: double.infinity, color: Colors.blue),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.blueGrey,
            ),
            Container(height: 100, width: double.infinity, color: Colors.green),
            Container(height: 100, width: double.infinity, color: Colors.amber),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.lightBlue,
            ),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.limeAccent,
            ),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.yellow,
            ),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.black12,
            ),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.orange,
            ),
          ],
        ),
        bottomNavigationBar: Hidable(
          controller: scrollController,
          enableOpacityAnimation: true,
          child: CurvedNavigationBar(
            backgroundColor: Colors.blueAccent,
            items: [
              const Icon(Icons.add, size: 30),
              const Icon(Icons.list, size: 30),
              const Icon(Icons.compare_arrows, size: 30),
            ],
            onTap: (index) {},
          ),
        ),
      ),
    );
  }
}
