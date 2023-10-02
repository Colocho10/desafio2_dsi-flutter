import 'package:desafio2_dsi/src/models/player.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Players extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlayerListScreen(),
    );
  }
}

class PlayerListScreen extends StatefulWidget {
  @override
  _PlayerListScreenState createState() => _PlayerListScreenState();
}

class _PlayerListScreenState extends State<PlayerListScreen> {
  List<Player> players = [];

  Future<void> fetchPlayers() async {
    final response =
        await http.get(Uri.parse('https://www.balldontlie.io/api/v1/players'));
    if (response.statusCode == 200) {
      final List<dynamic> playerData = json.decode(response.body)['data'];
      setState(() {
        players = playerData.map((data) => Player.fromJson(data)).toList();
      });
    } else {
      throw Exception('Failed to load players');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(players[index].firstName),
                subtitle: Text(players[index].lastName),
              ),
            ),
          );
        },
      ),
    );
  }
}
