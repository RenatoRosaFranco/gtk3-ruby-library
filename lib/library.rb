# frozen_string_literal: true

require_relative 'book'

class Library
	attr_reader :books

	def initialize
		@books = []
	end

	def add_book(book)
		books << book
	end

	def remove_book(isbn)
		books.reject! { |book| book.isbn == isbn }
	end

	def list_books
		books
	end

	def find_book(isbn)
		books.find { |book| book.isbn == isbn }
	end

	def borrow_book()
		book = find_book(isbn)
		return false unless book

		if book.available
			book.available = false
			true
		end
	end

	def return_book(isbn)
		book = find_book(isbn)
		return false unless book

		if !book.available
			book.available = true
			true
		end
	end
end
