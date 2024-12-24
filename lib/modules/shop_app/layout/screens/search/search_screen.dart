import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'search_screen',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}