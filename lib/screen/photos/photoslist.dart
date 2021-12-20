import 'package:eclipse/class/albums.dart';
import 'package:eclipse/screen/image/imagelist.dart';
import 'package:flutter/material.dart';
import 'package:eclipse/class/photos.dart';
import 'package:eclipse/class/users.dart';
import 'dart:convert';
import 'package:http/http.dart';

class Photos extends StatefulWidget {
  final User user;
  final AlbumsUsers albumsUsers;

  const Photos({Key? key, required this.user, required this.albumsUsers})
      : super(key: key);

  @override
  _PhotosState createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  Future<List<PhotosUsers>> getPhotos() async {
    final response = await get(
        Uri.parse('https://jsonplaceholder.typicode.com/photos?albumId=' +
                  widget.albumsUsers.id.toString()));

    if (response.statusCode == 200) {
      return List<PhotosUsers>.from(
          json.decode(response.body).map((x) => PhotosUsers.fromJson(x)));
    } else {
      throw Exception('Ошибка загрузкий' + widget.user.username + "Фотографий");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username + " - Фотографии"),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: FutureBuilder(
          future: getPhotos(),
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