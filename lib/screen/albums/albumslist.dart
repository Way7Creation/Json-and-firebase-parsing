import 'package:eclipse/class/users.dart';
import 'package:eclipse/screen/photos/photoslist.dart';
import 'package:flutter/material.dart';
import 'package:eclipse/class/albums.dart';
import 'dart:convert';

import 'package:http/http.dart';


class AlbumsUser extends StatefulWidget {
  final User user;

  const AlbumsUser({Key? key, required this.user}) : super(key: key);

  @override
  _AlbumsUserState createState() => _AlbumsUserState();
}

class _AlbumsUserState extends State<AlbumsUser> {
    Future<List<AlbumsUsers>> getAlbums() async {
      final response = await get(Uri.parse('https://jsonplaceholder.typicode.com/albums?userId=' +
                    widget.user.id.toString()));
    if (response.statusCode == 200) {
      return List<AlbumsUsers>.from(
          json.decode(response.body).map((x) => AlbumsUsers.fromJson(x)));
    } else {
      throw Exception('Ошибка загрузки ' + widget.user.username + " Альбомов");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username + " - Альбомы"),
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
                            builder: (context) => Photos(
                              user: widget.user,
                              albumsUsers: item,
                            ),
                          ),
                        );
                      },
                      title: Text(item.title),
                      subtitle: Text('@' + widget.user.username),
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