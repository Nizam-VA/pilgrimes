import 'package:flutter/material.dart';
import 'package:project_demo/models/pilgrim.dart';
import 'package:project_demo/screens/screen_view_pilgrim.dart';
import 'package:provider/provider.dart';

class PilgrimsList extends StatefulWidget {
  const PilgrimsList({super.key});

  @override
  State<PilgrimsList> createState() => _PilgrimsListState();
}

class _PilgrimsListState extends State<PilgrimsList> {
  @override
  Widget build(BuildContext context) {
    final pilgrims = Provider.of<List<Pilgrim>>(context);
    return ListView.builder(
      itemCount: pilgrims.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: 8,
          ),
          child: Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) =>
                        ScreenViewPilgrim(pilgrim: pilgrims[index]),
                  ),
                );
              },
              tileColor: Colors.brown[50],
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.brown,
              ),
              title: Text(pilgrims[index].place!),
              subtitle: Text(pilgrims[index].description!),
              trailing: Text(pilgrims[index].popular!.toString()),
            ),
          ),
        );
      },
    );
  }
}
