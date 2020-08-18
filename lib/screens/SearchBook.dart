import 'package:books_app/bloc/book_bloc.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/screens/detailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBook extends StatelessWidget {
  const SearchBook({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Books App"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<BookBloc, BookState>(
          listener: (context, state) {
            if (state is BookError) {
              return Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            return null;
          },
          builder: (context, state) {
            if (state is BookInitial) {
              return buildInitial();
            } else if (state is BookLoading) {
              return buildLoading();
            } else if (state is BookLoaded) {
              //return buildListWithData(context, state.books);
              return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  children: List.generate(state.books.length,
                      (index) => displayBook(context, state.books, index)));
            } else if (state is BookError) {
              return buildInitial();
            }
            return null;
          },
        ),
      ),
    );
  }
}

dynamic displayBook(BuildContext context, List<Book> books, int index) {
  return Hero(
      tag: books[index].volumeInfo.title,
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<BookBloc>(context),
                      child: BookDetail(book: books[index]),
                    )));
          },
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Card(
                child: Image.network(
                    books[index].volumeInfo.imageLinks["smallThumbnail"])),
          ),
        ),
      ));
}

Widget buildInitial() {
  return Center(
    child: UserNameInput(),
  );
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

class UserNameInput extends StatefulWidget {
  final BuildContext context;
  const UserNameInput({Key key, this.context});
  @override
  _UserNameInputState createState() => _UserNameInputState();
}

class _UserNameInputState extends State<UserNameInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitEvent(context, value), //TO DO
        textInputAction: TextInputAction.search,

        decoration: InputDecoration(
          hintText: "Enter a keyword title",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitEvent(BuildContext context, String keyWord) {
    final bloc = BlocProvider.of<BookBloc>(context);
    bloc.add(GetBook(keyWord));
    bloc.close();
  }
}

Widget buildListWithData(BuildContext context, List<Book> books) {
  return SingleChildScrollView(
      //  child:  books
      //       .map((e) => Container(
      //             child: ListView.builder(
      //               itemCount: books.length,
      //               itemBuilder: (context, index) {
      //                 return Image.network(books[index].volumeInfo.imageLinks[0]);
      //               },
      //             ),
      //           ))
      //       .toList()
      );
}
