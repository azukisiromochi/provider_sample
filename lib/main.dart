import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

/// ๐ ใใจใใจ MyApp ใๅฎ่กใใฆใใใ ใใ ใฃใใใ
///    ใขใใชๅจไฝใงๅฉ็จใใใใใซ Provider ใงใฉใใใใฆใใใ
void main() {
  runApp(
    MultiProvider(
      providers: [
        /// ๐ ใซใฆใณใฟใผใฎ็ถๆ็ฎก็ใฏใฉในใไฝฟใใใใใซใใญใใคใใผใจใใฆๅฎ็พฉ
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: const MyApp(),
    ),
  );
}

/// ๐ ใซใฆใณใฟใผใ็ถๆ็ฎก็ใใใใใซ ChangeNotifier ใ็ถๆฟใใ
class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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

/// ๐ ็ถๆ็ฎก็ใ Provider ใซๅงใญใใใ StatefullWIdget => StatelessWidget ใธ
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            Text(
              /// ๐ Provider ใง็ฎก็ใใใใซใฆใณใฟใผใ่กจ็คบ
              '${context.watch<Counter>().count}',
              key: const Key('counterState'),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        /// ๐ Provider ใง็ฎก็ใใใใซใฆใณใฟใผใใคใณใฏใชใกใณใ
        onPressed: () => context.read<Counter>().increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
