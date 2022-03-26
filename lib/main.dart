import 'dart:io';

import 'package:file_manager/controller/file_manager_controller.dart';
import 'package:file_manager/file_manager.dart';
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FileManagerController controller = FileManagerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 400,
              child: FileManager(
                controller: controller,
                builder: (context, snapshot) {
                  final List<FileSystemEntity> entities = snapshot;
                  if (snapshot.isNotEmpty) {
                    return ListView.builder(
                      itemCount: entities.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: FileManager.isFile(entities[index])
                                ? Icon(Icons.feed_outlined)
                                : Icon(Icons.folder),
                            title: Text(FileManager.basename(entities[index])),
                            onTap: () {
                              if (FileManager.isFile(entities[index])) {
                                getFileExtension(entities[index]);
                              }
                              if (FileManager.isDirectory(entities[index])) {
                                //  getFileExtension(entities[index]);
                                print("path ${controller.getCurrentPath}");
                                controller.openDirectory(
                                    entities[index]); // open directory

                              } else {
                                // Perform file-related tasks.
                              }
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Fetch")),
          ],
        ),
      ),
    );
  }

  static String getFileExtension(FileSystemEntity file) {
    print("fff $file");
    if (file is File) {
      return file.path.split("/").last.split('.jpg').last;
    } else {
      throw "FileSystemEntity is Directory, not a File";
    }
  }
}
