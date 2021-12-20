import 'package:eclipse/class/users.dart';
import 'package:eclipse/screen/albums/albumslist.dart';
import 'package:eclipse/screen/post/postlist.dart';
import 'package:flutter/material.dart';

class CardsScreen extends StatelessWidget {
  final User user;

  const CardsScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: BorderRadius.circular(16),
                elevation: 4,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amberAccent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amberAccent.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(user.name),
                                Spacer(),
                                Text(user.username),
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.phone_outlined),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(user.phone),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.language),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(user.website),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.work_outline),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(user.company.name),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 33.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('- ' + user.company.bs),
                                        Text(
                                          '- ' + user.company.catchPhrase,
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(user.address.street),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 33.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('- ' + user.address.suite),
                                        Text('- ' + user.address.city,
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                        Text('- ' + user.address.zipcode),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('- Geo: '),
                                            Text(user.address.geo.lat),
                                            Text(', '),
                                            Text(user.address.geo.lng),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PostsList(user: user)),
                    );
                  },
                  child: Text('Посмотреть все посты')),
              ],
            ),
            ),
          Expanded(
            flex: 0,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AlbumsUser(user: user)),
                    );
                  },
                  child: Text('Посмотреть все альбомы')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
