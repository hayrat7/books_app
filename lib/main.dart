import 'package:books_app/bloc/book_bloc.dart';
import 'package:books_app/repositories/bookrepository.dart';
import 'package:books_app/screens/SearchBook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Github Profiles',
        home: BlocProvider(
          create: (context) => BookBloc(BooksFromRemote()),
          child: SearchBook(),
        ));
  }
}
