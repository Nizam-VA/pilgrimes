import 'package:flutter/material.dart';
import 'package:project_demo/models/pilgrim.dart';
import 'package:project_demo/screens/screen_insertion.dart';
import 'package:project_demo/services/database.dart';
import 'package:project_demo/widgets/pilgrims_list.dart';
import 'package:provider/provider.dart';

class ScreenViewAll extends StatefulWidget {
  const ScreenViewAll({super.key});

  @override
  State<ScreenViewAll> createState() => _ScreenViewAllState();
}

class _ScreenViewAllState extends State<ScreenViewAll> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Pilgrim>>.value(
      value: DatabaseServices().pilgrims,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pilgrims'),
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton.extended(
            label: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ScreenInsertion(),
                ),
              );
            }),
        body: PilgrimsList(),
      ),
    );
  }
}
