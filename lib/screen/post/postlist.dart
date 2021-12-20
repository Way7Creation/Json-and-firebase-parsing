import 'dart:convert';
import 'package:eclipse/class/users.dart';
import 'package:flutter/material.dart';
import 'package:eclipse/screen/post/postscreen.dart';
import 'package:eclipse/class/posts.dart';
import 'package:http/http.dart';

class PostsList extends StatefulWidget {
  final User user;


  PostsList({Key? key, required this.user}) : super(key: key);

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  Future<List<PostUsers>> getUsers() async {
    final response = await get(Uri.parse('https://jsonplaceholder.typicode.com/posts?userId=' +
                  widget.user.id.toString()));

    if (response.statusCode == 200) {
      return List<PostUsers>.from(
          json.decode(response.body).map((x) => PostUsers.fromJson(x)));
    } else {
      throw Exception("ошибка публикаций");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username + " - Публикации"),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: FutureBuilder(
          future: getUsers(),
          builder: (BuildContext context, AsyncSnapshot<List<PostUsers>> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  for (var item in snapshot.data??[])
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        elevation: 4,
                        color: Colors.white,
                        child: ListTile(
                          onTap: () {Navigator.push(
                            context,
                              MaterialPageRoute(
                               builder: (context) => PostScreen(
                                   postUsers: item,
                                   user: widget.user),
                              ),
                            );
                          },
                          title: Text(item.title, style: TextStyle(),),
                          subtitle: Text(item.body, maxLines: 1),
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