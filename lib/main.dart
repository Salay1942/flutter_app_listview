import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users = getUsers();

  static List<User> getUsers() {
    const data = [
      {
        "username": "Sarah Abs",
        "email": "Sarah.Abs@gmail.com",
        "menu": [
          {
            "menuId": "001",
            "menuName": "ELECTRICITY",
            "urlAvatar":
                "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
          },
          {
            "menuId": "002",
            "menuName": "WATER SUPPLY",
            "urlAvatar": "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
          }
        ]
      },
      {
        "username": "Sarah Abs",
        "email": "Sarah.Abs@gmail.com",
        "urlAvatar":
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        "menu": [
          {
            "menuId": "003",
            "menuName": "LEASING",
            "urlAvatar":
                "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
          },
          {
            "menuId": "003",
            "menuName": "INSURANCE",
            "urlAvatar":
                "https://gravatar.com/avatar/7004a9d209ce6a89218d81b8c36d6cf6?s=400&d=robohash&r=x",
          }
        ]
      }
    ];
    return data.map<User>(User.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: buildUsers(users),
      ),
    );
  }
}

Widget buildUsers(List<User> users) => ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          child: Row(
            children: [
              for (int i = 0; i < user.menu.length; i++)
                Padding(
                    padding: const EdgeInsets.fromLTRB(8, 10, 10, 8),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(6),
                        onTap: () {
                          print("Click event on Container: " + user.menu[i].menuName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(user.menu[i].urlAvatar),
                              ),
                              const SizedBox(height: 8),
                              Text(user.menu[i].menuName)
                            ],
                          ),
                        ))), //Padding
            ],
          ),
        );
      },
    );

class User {
  String username;
  String email;
  List<Menu> menu;
  String? urlAvatar;

  User({
    required this.username,
    required this.email,
    required this.menu,
    this.urlAvatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
        urlAvatar: json["urlAvatar"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
        "urlAvatar": urlAvatar,
      };
}

class Menu {
  String menuId;
  String menuName;
  String urlAvatar;

  Menu({
    required this.menuId,
    required this.menuName,
    required this.urlAvatar,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        menuId: json["menuId"],
        menuName: json["menuName"],
        urlAvatar: json["urlAvatar"],
      );

  Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "menuName": menuName,
        "urlAvatar": urlAvatar,
      };
}
