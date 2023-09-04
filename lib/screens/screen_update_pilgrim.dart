import 'package:flutter/material.dart';
import 'package:project_demo/constants/constants.dart';
import 'package:project_demo/screens/screen_view_all.dart';
import 'package:project_demo/services/database.dart';

import '../models/pilgrim.dart';

class ScreenUpdatePilgrim extends StatefulWidget {
  Pilgrim pilgrim;
  ScreenUpdatePilgrim({super.key, required this.pilgrim});

  @override
  State<ScreenUpdatePilgrim> createState() => _ScreenUpdatePilgrimState();
}

class _ScreenUpdatePilgrimState extends State<ScreenUpdatePilgrim> {
  List<String> districts = ['Alappuzha', 'Eranakulam', 'Thrissur'];
  final _formKey = GlobalKey<FormState>();

  bool? _popular;
  String? _district;
  final _placeController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _popular = widget.pilgrim.popular!;
    _district = widget.pilgrim.district;
    _placeController.text = widget.pilgrim.place!;
    _descriptionController.text = widget.pilgrim.description!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Pilgrim'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 12),
                TextFormField(
                  controller: _placeController,
                  decoration: inputDecoration.copyWith(
                      label: const Text('Place name: ')),
                  validator: ((value) =>
                      value!.isEmpty ? 'Please enter a place name' : null),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionController,
                  decoration: inputDecoration.copyWith(
                      label: const Text('Description: ')),
                  validator: ((value) =>
                      value!.isEmpty ? 'Please enter a description' : null),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField(
                  decoration: inputDecoration.copyWith(label: Text('District')),
                  value: _district,
                  items: districts.map((district) {
                    return DropdownMenuItem(
                      child: Text('$district'),
                      value: district,
                    );
                  }).toList(),
                  onChanged: ((value) => setState(() => _district = value)),
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  value: _popular,
                  onChanged: (value) {
                    setState(() {
                      _popular = value!;
                    });
                  },
                  title: Text('Popular'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async {
                    String id = widget.pilgrim.id!;
                    String place = _placeController.text;
                    String description = _descriptionController.text;
                    String district = _district!;

                    final result = await DatabaseServices().updatePilgrim(
                        id, place, description, district, _popular!);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Updated data succesfully',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    );
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) => ScreenViewAll()),
                        (route) => false);
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
