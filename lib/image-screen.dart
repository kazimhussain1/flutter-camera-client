import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String imagePath;

  const ImageScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label:  Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Send", style: theme.typography.dense.headline6,),
            Padding(
              padding: const EdgeInsets.only(left:16.0),
              child: Icon(Icons.send),
            ),
          ],
        ),

        tooltip: "Send Button",
        onPressed: () async {
          var imageFile = File(imagePath);
          var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
          // get file length
          var length = await imageFile.length();

          var url = Uri(host: 'https://jsonplaceholder.typicode.com/');

          var request = new http.MultipartRequest("POST", url);

          // multipart that takes file
          var multipartFile = new http.MultipartFile('file', stream, length,
              filename: basename(imageFile.path));

          // add file to multipart
          request.files.add(multipartFile);

          // send
          var response = await request.send();

        },
      ),
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Stack(
        children: [
          Image.file(File(imagePath)),

        ],
      ),
    );
  }
}
