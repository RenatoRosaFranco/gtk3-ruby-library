# frozen_string_literal: true

require 'json'
require_relative 'book'
require_relative 'library_storage'

class Library
	PATH = 'data/library.json'

	attr_reader :books, :storage, :file_path

	def initialize(file_path = PATH)
		@file_path = file_path
		@storage = LibraryStorage
		@books = load_from_json
		list_books
	end

	def add_book(book)
		books << book
		save_to_json
		list_books
	end

	def remove_book_by_id(id)
		books.reject! { |book| book.id == id }
	end

	def find_book_by_id(id)
		books.find { |book| book.id == id }
	end

	def remove_book(isbn)
		books.reject! { |book| book.isbn == isbn }
		save_to_json
		list_books
	end

	def list_books
		books
	end

	def find_book(isbn)
		books.find { |book| book.isbn == isbn }
	end

	def borrow_book(isbn)
    if toggle_availability(isbn, true)
			save_to_json
			list_books
		end
	end

	def return_book(isbn)
    if toggle_availability(isbn, false)
			save_to_json
			list_books
		end
	end

	def save_to_json
		storage.save_to_json(books, file_path)
	end

	def load_from_json
		storage.load_from_json(file_path)
	end

	def toggle_availability(isbn, make_unavailable)
		book = find_book(isbn)
		return false unless book

		if book.available != make_unavailable
			book.available = make_unavailable
			true
		else
			false
		end
	end
end
