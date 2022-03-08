import 'package:flutter/material.dart';
import 'package:nagib_pay/bloc/users/users_event.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: Theme.of(context).textTheme.headline1,
          hintText: "Поиск..."),
      onChanged: (searchText) {
        SearchBarChanged(searchText: searchText);
      },
    );
  }
}
