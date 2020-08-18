import 'package:books_app/bloc/book_bloc.dart';
import 'package:books_app/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetail extends StatefulWidget {
  final Book book;

  const BookDetail({Key key, this.book}) : super(key: key);
  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  void didChangeDependencies() {
    BlocProvider.of<BookBloc>(context)
      ..add(GetBook(widget.book.volumeInfo.title));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Books App"),
        centerTitle: true,
      ),
      body: Container(child: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            buildLoading();
          } else if (state is BookLoaded) {
            return buildColumnWithData(context, widget.book);
          }
        },
      )),
    );
  }

  Widget buildColumnWithData(BuildContext context, Book book) {
    return Hero(
      tag: book.volumeInfo.title,
      child: book.volumeInfo == null
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              reverse: true,
              physics: ScrollPhysics(),
              padding: EdgeInsets.all(18),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    child: Image.network(
                      book.volumeInfo.imageLinks['thumbnail'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      book.volumeInfo.title,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Author:",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          " ${book.volumeInfo.authors[0]}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Published Date:",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          book.volumeInfo.publishedDate,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Categories:",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          book.volumeInfo.categories[0],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Expanded(
                          child: Text(
                            "Number of Pages:",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          book.volumeInfo.pageCount.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      book.volumeInfo.description,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
// Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Expanded(
//                       child: Text(
//                         book.volumeInfo.publishedDate,
//                         style: TextStyle(color: Colors.redAccent, fontSize: 20),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         book.volumeInfo.publishedDate,
//                         style: TextStyle(color: Colors.redAccent, fontSize: 20),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
