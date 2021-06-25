import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

      // 最初に表示するWidgetをアドレスで指定できる
      initialRoute: "/subA",

      // MaterialAppで遷移先のWidgetとアドレス的な文字列を登録
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => const MainPage(),
        "/subA": (BuildContext context) => const SubPage(page: SubPages.pageA),
        "/subB": (BuildContext context) => const SubPage(page: SubPages.pageB),
        "/subC": (BuildContext context) => const SubPage(page: SubPages.pageC),
        "/subD": (BuildContext context) => const SubPage(page: SubPages.pageD),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MainPage"),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // アドレスを指定してPushする処理をボタンなどに付属する
              // Navigator.of(context).pushNamed("/sub");
              // MaterialPageRouteを使えばアドレスの指定は不要
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubPage(page: SubPages.pageA),
                ),
              );
            },
            child: const Text("Present Sub Widget"),
          ),
        ),
      ),
    );
  }
}

enum SubPages { pageA, pageB, pageC, pageD }

class SubPage extends StatelessWidget {
  const SubPage({Key? key, required this.page}) : super(key: key);

  final SubPages page;

  @override
  Widget build(BuildContext context) {
    // SubPagesの値によって表示するページを帰る
    Widget widget;
    switch (page) {
      case SubPages.pageA:
        widget = Container(
          color: Colors.orange,
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "A",
                style: TextStyle(color: Colors.white, fontSize: 100.0),
              ),
              ElevatedButton(
                onPressed: () => {Navigator.pushNamed(context, "/subB")},
                child: const Text("Bへすすむ"),
              ),
            ]),
          ),
        );
        break;
      case SubPages.pageB:
        widget = Container(
          color: Colors.blue,
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "B",
                style: TextStyle(color: Colors.white, fontSize: 100.0),
              ),
              ElevatedButton(
                onPressed: () => {Navigator.pushNamed(context, "/subC")},
                child: const Text("Cへすすむ"),
              ),
            ]),
          ),
        );
        break;
      case SubPages.pageC:
        widget = Container(
          color: Colors.red,
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "C",
                style: TextStyle(color: Colors.white, fontSize: 100.0),
              ),
              ElevatedButton(
                onPressed: () => {Navigator.pushNamed(context, "/subD")},
                child: const Text("Dへすすむ"),
              ),
            ]),
          ),
        );
        break;
      case SubPages.pageD:
        widget = Container(
          color: Colors.lime,
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "D",
                style: TextStyle(color: Colors.white, fontSize: 100.0),
              ),
              ElevatedButton(
                onPressed: () =>
                    {Navigator.popUntil(context, (route) => route.isFirst)},
                child: const Text("Aへ戻る"),
              ),
            ]),
          ),
        );
    }

    return Scaffold(
      body: widget,
    );
  }
}
