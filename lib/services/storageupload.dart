import 'package:firebase_storage/firebase_storage.dart';
//import 'package:universal_html/html.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:provider/provider.dart';
// import 'package:universal_html/html.dart';

class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://crimson-ministry.appspot.com');

  final DatabaseService _data = DatabaseService();

  StorageUploadTask _uploadTask;
  var url;

  startUpload(String userId) async {
    String filePath = 'images/$userId.png';
    final storageRef = FirebaseStorage.instance.ref().child(filePath);
    _uploadTask = storageRef.putFile(widget.file);
    final snapshot = await _uploadTask.onComplete;
    if (snapshot.error != null) {
      print('upload error code: ${snapshot.error}');
      throw snapshot.error;
    }
    url = await snapshot.ref.getDownloadURL();
    print('download URL: $url');
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    String userId = user.uid;
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;
            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;
            return Column(
              children: [
                if (_uploadTask.isComplete) ...[
                  Text('Profile Image Uploaded!'),
                ],
                LinearProgressIndicator(
                  value: progressPercent,
                ),
                Text('${(progressPercent * 100).toStringAsFixed(2)} %'),
              ],
            );
          });
    } else {
      return FlatButton.icon(
        label: Text('Upload Image'),
        icon: Icon(Icons.check_circle),
        onPressed: () async {
          await startUpload(userId);
          await _data.updateUserAvatar(userId, url);
          Navigator.of(context).pop();
        },
      );
    }
  }
}
