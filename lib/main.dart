import 'package:flutter/material.dart';

void main() => runApp(BetterSettlersApp());

class BetterSettlersApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.lightBlue[500],
        accentColor: Colors.lightGreen[500],
      ),
      home: HomePage(title: 'Better Settlers'),
    );
  }
}

class OtherPage extends StatefulWidget {
  OtherPage({Key key, this.content}) : super(key: key);

  final String content;

  @override
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
  );
  @override
  Widget build(BuildContext context) {
    return Text(
      'This page is about ${widget.content}',
      style: optionStyle,
    );
  }
}

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Sky(),
      child: Center(),
    );
  }
}

class Sky extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawRect(rect, paint);

    Path path = Path();
    path.moveTo(100, 100);
    path.lineTo(120, 80);
    path.lineTo(140, 80);
    path.lineTo(160, 100);
    path.lineTo(140, 120);
    path.lineTo(120, 120);
    path.lineTo(100, 100);

    canvas.drawPath(
      path,
      paint,
    );
//    var gradient = RadialGradient(
//      center: const Alignment(0.0, 0.0),
//      radius: 0.2,
//      colors: [const Color(0xFFFFFF00), const Color(0xFF0099FF)],
//      stops: [0.4, 1.0],
//    );
//    canvas.drawRect(
//      rect,
//      Paint()
//        ..shader = gradient.createShader(rect),
//    );
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(Sky oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(Sky oldDelegate) => false;
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static List<Widget> _tabs = <Widget>[
    MapPage(),
    OtherPage(content: 'Seafarers'),
    OtherPage(content: 'Probability Tracker'),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _refresh() {
    setState(() {
      // TODO
    });
  }


  void _openPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Next page'),
          ),
          body: const Center(
            child: Text(
              'This is the next page',
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Show Snackbar',
              onPressed: () {
                // TODO
              },
            ),
            IconButton(
              icon: const Icon(Icons.info),
              tooltip: 'Next page',
              onPressed: () {
                _openPage(context);
              },
            ),
          ],
        ),
        body: Center(
          child: _tabs.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.landscape),
              title: Text('Classic'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_boat),
              title: Text('Seafarers'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_on),
              title: Text('Probability Tracker'),
            ),
          ],
          selectedItemColor: Colors.amber[800],
          onTap: _onTabTapped,
          currentIndex: _selectedIndex,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _refresh,
          label: Text('Refresh'),
          tooltip: 'Refresh',
          icon: Icon(Icons.refresh),
        ),
    );
  }
}
