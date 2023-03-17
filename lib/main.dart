import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late RiveAnimationController _rController;
  late StateMachineController? _smController;
  SMITrigger? _bump;
  @override
  void initState() {
    _rController = SimpleAnimation('intro');
    super.initState();
  }

  void _onInit(Artboard art) {
    _smController = StateMachineController.fromArtboard(art, 'uploading_state')
        as StateMachineController;

    art.addController(_smController!);
    // Get State Machine Controller for the state machine called "bumpy"
    // Get a reference to the "bump" state machine input
    _bump = _smController!.findInput<bool>('input') as SMITrigger;
    setState(() {});
  }

  void _hitBump() {
    // _smController.
    if (_bump != null) {
      _bump!.value ? _bump!.advance() : _bump?.fire();
    }
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
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: [
            Expanded(
              child: RiveAnimation.asset(
                'assets/digiin.riv',
                controllers: [_rController],
                onInit: _onInit,
                stateMachines: const ['intro 3'],
              ),
            ),
            Row(
              children: [
                FloatingActionButton(
                  onPressed: _hitBump,
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
