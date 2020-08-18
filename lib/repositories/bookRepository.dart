import 'package:books_app/models/book.dart';
import 'package:books_app/services/networking.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks(String keyWord);
}

class BooksFromRemote implements BookRepository {
  @override
  Future<List<Book>> getBooks(String keyWord) async {
    final booksData = await Networking(keyword: keyWord).getBooksData();
    if (booksData == null) {
      throw NetworkError();
    }
    List<Book> books =
        (booksData['items'] as List).map((el) => Book.fromJson(el)).toList();
    return books;
  }
}

class NetworkError extends Error {}
