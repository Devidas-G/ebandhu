import 'package:ebandhu/di.dart';
import 'package:ebandhu/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    'Preferencess': [
      {
        Icons.exit_to_app: {
          "Logout": () {
            sl<AuthBloc>().add(LogoutEvent());
          },
        },
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
