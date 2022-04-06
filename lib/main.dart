import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

/// 🚀 もともと MyApp を実行していただけだったが、
///    アプリ全体で利用するために Provider でラップしている。
void main() {
  runApp(
    MultiProvider(
      providers: [
        /// 🚀 カウンターの状態管理クラスを使えるようにプロバイダーとして定義
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: const MyApp(),
    ),
  );
}

/// 🚀 カウンターを状態管理するために ChangeNotifier を継承する
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

/// 🚀 状態管理を Provider に委ねるため StatefullWIdget => StatelessWidget へ
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
              /// 🚀 Provider で管理されたカウンターを表示
              '${context.watch<Counter>().count}',
              key: const Key('counterState'),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        /// 🚀 Provider で管理されたカウンターをインクリメント
        onPressed: () => context.read<Counter>().increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
