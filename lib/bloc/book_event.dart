part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class GetBook extends BookEvent {
  final String keyWord;

  const GetBook(this.keyWord);
}
