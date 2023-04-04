import 'dart:math' as math;
import 'package:flutter/material.dart';

const String _link1 =
    'https://phonoteka.org/uploads/posts/2021-05/1622329916_9-phonoteka_org-p-kot-za-kompyuterom-art-krasivo-12.jpg';
const String _link2 = 'https://ae04.alicdn.com/kf/H864bb1344a5a42fda700207f0d7a316aS.jpg_640x640.jpg';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Material',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Material'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _bottomNavigation.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _counter = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 12),
    foregroundColor: Colors.black,
    backgroundColor: Colors.white60,
    elevation: 2.0,
  );

  void _toggleBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 200,
        child: Column(
          children: [
            ListTile(
              title: Text('Сумма'),
              leading: Icon(Icons.payment),
              trailing: Text('200 руб'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Оплатить'),
              style: _buttonStyle,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar Title'),
        actions:[
          Builder(builder: (context) =>
            IconButton(
              icon: Icon(Icons.account_circle_rounded),
              onPressed: () { Scaffold.of(context).openEndDrawer(); },
            )
          )
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                  child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(_link1),
              )),
              ..._drawerNavigation.map((element) {
                return ListTile(
                  title: Text(element.title),
                  leading: Icon(element.icon),
                  trailing: Icon(element.navIcon),
                );
              }),
              Spacer(),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: _buttonStyle,
                      onPressed: () {},
                      child: Text('Выход')),
                  ElevatedButton(
                      style: _buttonStyle,
                      onPressed: () {},
                      child: Text('Регистрация')),
                ],
              )),
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.cyan,
        child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(_link2),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Имярек Имярекович')
            ),
          ],
        )),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          for (final item in _bottomNavigation)
            Container(
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(0.3),
              child: Center(
                  child: Text(
                _counter.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
            child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _tabController.index = index;
            });
          },
          currentIndex: _tabController.index,
          elevation: 0,
          items: [
            for (final item in _bottomNavigation)
              BottomNavigationBarItem(label: item.title, icon: Icon(item.icon))
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _toggleBottomSheet,
      ),
    );
  }
}

class _Navigation {
  final String title;
  final IconData icon;
  final IconData navIcon;

  _Navigation({this.title, this.icon, this.navIcon = null});
}

final _drawerNavigation = [
  _Navigation(
      title: 'Home', icon: Icons.home, navIcon: Icons.arrow_forward_ios),
  _Navigation(
      title: 'Profile',
      icon: Icons.account_box_outlined,
      navIcon: Icons.arrow_forward_ios),
  _Navigation(
      title: 'Images', icon: Icons.image, navIcon: Icons.arrow_forward_ios),
];

final _bottomNavigation = [
  _Navigation(title: 'Photo', icon: Icons.home),
  _Navigation(title: 'Chat', icon: Icons.chat),
  _Navigation(title: 'Albums', icon: Icons.adjust),
];
