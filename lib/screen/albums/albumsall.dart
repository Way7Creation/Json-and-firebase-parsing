import 'package:eclipse/screen/photos/photolistall.dart';
import 'package:flutter/material.dart';
import 'package:eclipse/class/albums.dart';
import 'dart:convert';
import 'package:http/http.dart';

class AlbumsUserAll extends StatefulWidget {
  const AlbumsUserAll({Key? key}) : super(key: key);

  @override
  _AlbumsUserAllState createState() => _AlbumsUserAllState();
}

class _AlbumsUserAllState extends State<AlbumsUserAll> {
  Future<List<AlbumsUsers>> getAlbums() async {
    final response = await get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      List<AlbumsUsers> listOfAlbumsUsers = items.map<AlbumsUsers>((json) {
        return AlbumsUsers.fromJson(json);
      }).toList();

      return listOfAlbumsUsers;
    } else {
      throw Exception('Ошибка заагрузки');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Альбомы'),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: FutureBuilder(
          future: getAlbums(),
          builder: (BuildContext context, AsyncSnapshot<List<AlbumsUsers>> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  for (var item in snapshot.data??[])
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PhotosAll(
                              // user: item,
                              // albumsUsers: item,
                            ),
                          ),
                        );
                      },
                      title: Text(item.title),
                      // subtitle: Text(widget.user.username),
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