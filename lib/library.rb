# frozen_string_literal: true

require 'json'
require_relative 'book'

class Library
	attr_reader :books

	def initialize
		@books = load_from_json('data/library.json')
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

	def borrow_book(isbn)
    toggle_availability(isbn, true)
	end

	def return_book(isbn)
    toggle_availability(isbn, false)
	end

	def save_to_json(file_path)
		File.open(file_path, 'w') do |file|
			json_data = @books.map { |book| { title: book.title, author: book.author, available: book.available }}
			file.write(JSON.pretty_generate(json_data))
		end
	end

	def load_from_json(file_path)
		if File.exist?(file_path)
			json_data = JSON.parse(File.read(file_path))
			@books = json_data.map do |book_data|
				Book.new(book_data['title'], book_data['author'], book_data['isbn']).tap do
					book.available = book_data['available']
				end
			end
		else
			puts "File not found: #{file_path}"
		end
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
