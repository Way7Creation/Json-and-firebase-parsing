import 'package:eclipse/screen/image/imagelist.dart';
import 'package:flutter/material.dart';
import 'package:eclipse/class/photos.dart';
import 'dart:convert';
import 'package:http/http.dart';

class PhotosAll extends StatefulWidget {
  const PhotosAll({Key? key}) : super(key: key);

  @override
  _PhotosAllState createState() => _PhotosAllState();
}

class _PhotosAllState extends State<PhotosAll> {
  Future<List<PhotosUsers>> getAlbums() async {
    final response = await get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      List<PhotosUsers> listOfPhotosUsers = items.map<PhotosUsers>((json) {
        return PhotosUsers.fromJson(json);
      }).toList();

      return listOfPhotosUsers;
    } else {
      throw Exception('Failed to load internet');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Фотографии"),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: FutureBuilder(
          future: getAlbums(),
          builder: (BuildContext context, AsyncSnapshot<List<PhotosUsers>> snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 3,
                children: <Widget>[
                  for (var item in snapshot.data??[])
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageViewer(
                              photosUsers: item,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: Image.network(
                          item.thumbnailUrl,
                        ),
                      ),
                    ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}