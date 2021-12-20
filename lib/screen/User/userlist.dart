import 'dart:convert';
import 'package:eclipse/screen/User/cardscreen.dart';
import 'package:flutter/material.dart';
import 'package:eclipse/class/users.dart';
import 'package:http/http.dart';
import 'package:firebase_database/firebase_database.dart';



class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {



  Future<List<User>> getUsers() async {
    final response = await get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      List<User> listOfUsers = items.map<User>((json) {
        return User.fromJson(json);
      }).toList();

      return listOfUsers;
    } else {
      throw Exception('Не удалось загрузить пользователей');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список пользователей'),
      ),
      body: Container(
        child: FutureBuilder(
          future: getUsers(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  for (var item in snapshot.data??[])
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CardsScreen(user: item),
                          ),
                        );
                      },
                      title: Text(item.name),
                      subtitle: Text(item.username),
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