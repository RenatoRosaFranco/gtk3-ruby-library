# frozen_string_literal: true

class Book
	attr_accessor :title, :author, :isbn, :available

	def initialize(title, author, isbn)
		@title = title
		@author = author
		@isbn = isbn
		@available = true
	end
end