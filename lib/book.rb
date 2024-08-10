# frozen_string_literal: true

class Book
	attr_accessor :id, :title, :author, :isbn, :available

	@@id_counter = 1

	def initialize(title, author, isbn)
		@id = @@id_counter
		@@id_counter += 1
		@title = title
		@author = author
		@isbn = isbn
		@available = true
	end
end
