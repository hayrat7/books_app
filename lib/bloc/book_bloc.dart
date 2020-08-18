import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/repositories/bookrepository.dart';
import 'package:equatable/equatable.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;
  BookBloc(this.bookRepository) : super(BookInitial());

  @override
  Stream<BookState> mapEventToState(
    BookEvent event,
  ) async* {
    if (event is GetBook) {
      yield BookLoading();
      try {
        final books = await bookRepository.getBooks(event.keyWord);
        yield BookLoaded(books);
      } on NetworkError {
        yield BookError(
            "Oups couldn't get data,be sure that you entred a valide keyword or check your connexion internet");
      }
    }
  }
}
