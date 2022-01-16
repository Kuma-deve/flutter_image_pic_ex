import 'package:flutter/material.dart';
import 'package:flutter_image_pic_ex/camera.model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PicExample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CameraModel()..fetchWidget(),
      child: Scaffold(
        body: Consumer<CameraModel>(builder: (context, model, child) {
          return ListView.builder(
            itemCount: model.list.length,
            itemBuilder: (BuildContext context, int index) {
              return model.list[index];
            },
          );
        }),
      ),
    );
  }
}
