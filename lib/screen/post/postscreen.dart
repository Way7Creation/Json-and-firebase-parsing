import 'dart:convert';
import 'package:eclipse/class/comments.dart';
import 'package:eclipse/class/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eclipse/class/posts.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';

class PostScreen extends StatefulWidget {
  final PostUsers postUsers;
  final User user;

  const PostScreen({
    Key? key,
    required this.postUsers,
    required this.user,
  }) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    getCommentUsers();
  }

  Future<List<CommentUsers>> getCommentUsers() async {
    final response = await get(Uri.parse(
        'https://jsonplaceholder.typicode.com/comments?postId=' +
            widget.postUsers.id.toString()));
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      List<CommentUsers> listOfCommentUsers = items.map<CommentUsers>((json) {
        return CommentUsers.fromJson(json);
      }).toList();

      return listOfCommentUsers;
    } else {
      throw Exception('Ошибка заагрузки');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.postUsers.title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                  borderRadius: BorderRadius.circular(16),
                  elevation: 4,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.amberAccent,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.amberAccent.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '@' + widget.user.username,
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                      Spacer(),
                                      Text(widget.user.name),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.postUsers.title,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.postUsers.body),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.all(10.0),
            child: const Text(
              'Комментарии:',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 2,
            child: FutureBuilder(
              future: getCommentUsers(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<CommentUsers>> snapshot) {
                if (snapshot.hasData) {
                  return ListView(children: [
                    for (var item in snapshot.data ?? [])
                      ListTile(
                        onTap: () {},
                        title: Material(
                            borderRadius: BorderRadius.circular(16),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item.name,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(item.email),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(item.body),
                                  ),
                                  // Text(item.id),
                                ],
                              ),
                            )),
                      ),
                  ]);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
