import 'package:flutter/material.dart';
import 'package:project_demo/models/pilgrim.dart';
import 'package:project_demo/screens/screen_update_pilgrim.dart';
import 'package:project_demo/services/database.dart';

class ScreenViewPilgrim extends StatefulWidget {
  Pilgrim pilgrim;
  ScreenViewPilgrim({super.key, required this.pilgrim});

  @override
  State<ScreenViewPilgrim> createState() => _ScreenViewPilgrimState();
}

class _ScreenViewPilgrimState extends State<ScreenViewPilgrim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pilgrim.place!),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  widget.pilgrim = widget.pilgrim;
                });
              },
              icon: const Icon(Icons.refresh)),
          PopupMenuButton(
            onSelected: (value) async {
              if (value == 'edit') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) =>
                        ScreenUpdatePilgrim(pilgrim: widget.pilgrim)));
              }
              if (value == 'delete') {
                await DatabaseServices().deletePilgrim(widget.pilgrim.id!);
                Navigator.of(context).pop();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('Edit'), value: 'edit'),
              const PopupMenuItem(child: Text('Delete'), value: 'delete'),
            ],
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.brown[50],
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Text(widget.pilgrim.place!, style: TextStyle(fontSize: 18)),
              const SizedBox(height: 12),
              Text(
                widget.pilgrim.description!,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 12),
              Text(widget.pilgrim.district!, style: TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              Text(widget.pilgrim.popular!.toString(),
                  style: TextStyle(
                      color:
                          widget.pilgrim.popular! ? Colors.green : Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
