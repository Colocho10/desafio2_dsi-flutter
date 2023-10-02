import 'dart:convert';
import 'package:desafio2_dsi/src/models/team.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  List<Team> teams = [];

  // Metodo GET para obtener equipos
  Future getTeams() async {
    var response = await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));
    var jsonData = jsonDecode(response.body);

    for (var eachTeam in jsonData['data']) {
      final team = Team(
        abbreviation: eachTeam['abbreviation'],
        city: eachTeam['city'],
        fullName: eachTeam['full_name'],
      );
      teams.add(team);
    }

    print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getTeams(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: teams.length,
                  padding: EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(teams[index].abbreviation),
                          subtitle: Text(teams[index].city),
                          onTap: () {
                            //Navegacion stack
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TeamDetailScreen(
                                  fullName: teams[index].fullName,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

//Botton de Navegacion
class TeamDetailScreen extends StatelessWidget {
  final String fullName;

  TeamDetailScreen({required this.fullName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de Equipo'),
      ),
      body: Center(
        child: Text(
          fullName,
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
