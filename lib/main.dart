import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1520',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: AnimatedAppBarScreen(title: '1520 Test'),
    );
  }
}

class AnimatedAppBarScreen extends HookWidget {
  AnimatedAppBarScreen(
      {Key? key,
      required this.title,
      this.appBarMaxHeight = 150,
      this.appBarMinHeight = 40})
      : super(key: key);

  final double appBarMaxHeight;
  final double appBarMinHeight;
  final String title;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    final isCollapsed = useState<bool>(false);
    final controller = useScrollController();

    controller.addListener(() {
      isCollapsed.value =
          controller.offset > (appBarMaxHeight - appBarMinHeight);
    });

    final list = List<Widget>.generate(
        50,
        (index) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Container(
                color: Colors.grey[300],
                height: 50,
              ),
            ));
    return Scaffold(
      body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          controller: controller,
          slivers: [
            SliverAppBar(
              stretch: true,
              brightness:
                  isCollapsed.value ? Brightness.light : Brightness.dark,
              pinned: true,
              backgroundColor: Colors.white,
              collapsedHeight: appBarMinHeight,
              toolbarHeight: appBarMinHeight,
              expandedHeight: appBarMaxHeight,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding:
                    const EdgeInsetsDirectional.only(start: 72, bottom: 10),
                title: Text(
                  title,
                  style: TextStyle(
                      color:
                          isCollapsed.value ? Colors.grey[900] : Colors.white),
                ),
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground
                ],
                background: Image.asset(
                  'assets/dark.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => i == 0
                    ? SizedBox(
                        height: 5,
                      )
                    : list[i - 1],
                childCount: list.length + 1,
              ),
            ),
          ]),
    );
  }
}
