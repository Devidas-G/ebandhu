import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  Map<String, List<Map<IconData, Map<String, Function>>>> optionTiles = {
    'General': [
      {
        Icons.person: {
          "Edit Profile": () {
            print("object");
          },
        },
      },
      {
        Icons.password: {"Change Password": () {}},
      },
    ],
    'Genera': [
      {
        Icons.person: {"Edit Profile": () {}},
      },
      {
        Icons.password: {"Change Password": () {}},
      },
    ],
    'Geneal': [
      {
        Icons.person: {"Edit Profile": () {}},
      },
      {
        Icons.password: {"Change Password": () {}},
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children:
                optionTiles.entries.map((option) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(option.key),
                        Column(
                          children:
                              option.value.map((
                                Map<IconData, Map<String, Function>> tiles,
                              ) {
                                return Column(
                                  children:
                                      tiles.entries.map((tile) {
                                        String title =
                                            tile.value.entries.first.key;
                                        Function ontap =
                                            tile.value.entries.first.value;
                                        return ListTile(
                                          onTap: () => ontap(),
                                          leading: Icon(tile.key),
                                          title: Text(title),
                                          trailing: Icon(
                                            Icons.arrow_forward_ios,
                                          ),
                                        );
                                      }).toList(),
                                );
                              }).toList(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
