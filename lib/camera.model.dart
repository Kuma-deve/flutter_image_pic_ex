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
  var imageFile;
  Uint8List webImage = Uint8List(10);
  final picker = ImagePicker();
  var widget_list = <Widget>[];
  List? url;

  void fetchWidget() {
    widget_list.add(
      InkWell(
        onTap: () async {
          await pickImage();
        },
        child: Container(
          width: 150,
          height: 150,
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 100,
                  child: Icon(Icons.add_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //widget_listというwidgetのリストを作る
  //画面初期化
  Future pickImage() async {
    if (!kIsWeb) {
      //以下モバイル版の処理
      XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        widget_list.add(
          Image.file(imageFile!),
        );
        notifyListeners();
      }
    } else if (kIsWeb) {
      //以下web版の処理
      XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        var f = await pickedFile.readAsBytes();
        imageFile = f;
        widget_list.add(
          Image.memory(imageFile),
        );
        notifyListeners();
      }
    }
  }
}
