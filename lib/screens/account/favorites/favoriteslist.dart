import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'favoritetile.dart';

class FavoritesList extends StatefulWidget {
  final List<String> favorites;
  FavoritesList(this.favorites);

  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
        value: DatabaseService().users,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.favorites.length,
          itemBuilder: (context, index) {
            return FavoriteTile(username: widget.favorites[index]);
          },
        ));
  }
}
