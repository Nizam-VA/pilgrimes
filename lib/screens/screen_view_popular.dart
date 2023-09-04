import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScreenViewPopular extends StatefulWidget {
  const ScreenViewPopular({super.key});

  @override
  State<ScreenViewPopular> createState() => _ScreenViewPopularState();
}

class _ScreenViewPopularState extends State<ScreenViewPopular> {
  List popular = [];

  Future<void> popularPilgrims() async {
    final result = await FirebaseFirestore.instance
        .collection('pilgrims')
        .where('popular', isEqualTo: true)
        .get();
    setState(() {
      popular = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Pilgrims'),
      ),
      body: ListView.builder(
          itemCount: popular.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: popular[index]['place'],
            );
          }),
    );
  }
}
