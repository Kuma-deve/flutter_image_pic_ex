import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Photo {
  Photo(this.widget);
  Widget widget;
}

class CameraModel extends ChangeNotifier {
  File? imageFile;
  Uint8List webImage = Uint8List(10);
  final picker = ImagePicker();
  var list = <Widget>[];
  List? url;

  void fetchWidget() {
    list.add(
      Container(
        width: 150,
        height: 150,
        color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: const SizedBox(
                  width: 100,
                  child: Icon(Icons.add_outlined),
                ),
                onTap: () async {
                  await pickImage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //listというwidgetのリストを作る
  //画面初期化
  Future pickImage() async {
    if (!kIsWeb) {
      //以下モバイル版の処理
      XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        //url!.add(imageFile!.path);
        list.add(
          Image.file(imageFile!),
        );
        notifyListeners();
      }
    } else if (kIsWeb) {
      //以下web版の処理
      XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        var f = await pickedFile.readAsBytes();
        imageFile = File("web");
        webImage = f;
        //url!.add(webImage);
        list.add(
          Image.memory(webImage),
        );
        notifyListeners();
      }
    }
  }
}
