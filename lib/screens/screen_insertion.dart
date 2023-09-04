import 'package:flutter/material.dart';
import 'package:project_demo/constants/constants.dart';
import 'package:project_demo/screens/screen_view_all.dart';
import 'package:project_demo/screens/screen_view_popular.dart';
import 'package:project_demo/services/database.dart';

class ScreenInsertion extends StatefulWidget {
  const ScreenInsertion({super.key});

  @override
  State<ScreenInsertion> createState() => _ScreenInsertionState();
}

class _ScreenInsertionState extends State<ScreenInsertion> {
  List<String> districts = ['Alappuzha', 'Eranakulam', 'Thrissur'];
  final _formKey = GlobalKey<FormState>();

  String id = DateTime.now().toString();
  String? _place;
  String? _description;
  String? _district;
  bool _popular = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert Data'),
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => ScreenViewAll()));
            },
            icon: const Icon(Icons.next_plan_outlined, color: Colors.white),
            label:
                const Text('View All', style: TextStyle(color: Colors.white)),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => ScreenViewPopular()));
            },
            icon: const Icon(Icons.all_inbox_outlined),
          ),
        ],
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
                  decoration: inputDecoration.copyWith(
                      label: const Text('Place name: ')),
                  validator: ((value) =>
                      value!.isEmpty ? 'Please enter a place name' : null),
                  onChanged: ((value) => setState(() => _place = value)),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: inputDecoration.copyWith(
                      label: const Text('Description: ')),
                  validator: ((value) =>
                      value!.isEmpty ? 'Please enter a description' : null),
                  onChanged: ((value) => setState(() => _description = value)),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField(
                  decoration: inputDecoration.copyWith(label: Text('District')),
                  value: districts[0],
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
                    if (_formKey.currentState!.validate()) {
                      await DatabaseServices(id: id).insertPilgrims(
                          id, _place!, _description!, _district!, _popular);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
