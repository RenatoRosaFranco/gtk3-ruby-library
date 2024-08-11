# frozen_string_literal: true

require_relative './book'
class Library
  def add_book(book)
    book.save
  end

  def remove_book_by_id(id)
    book = Book.find_by(id: id)
    book.destroy if book
  end

  def find_book_by_id(id)
    Book.find_by(id: id)
  end

  def remove_book(isbn)
    book = Book.find_by(isbn: isbn)
    book.destroy if book
  end

  def list_books
    Book.all
  end

  def borrow_book(isbn)
    book = Book.find_by(isbn: isbn)
    if book && book.available
      book.update(available: false)
    end
  end

  def return_book(isbn)
    book = Book.find_by(isbn: isbn)
    if book && !book.available
      book.update(available: true)
    end
  end
end
