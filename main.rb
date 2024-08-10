require 'gtk3'
require_relative 'lib/library'
require_relative 'lib/book'

class LibraryApp
  FILE_PATH = 'data/library.json'

  def initialize
    @library = Library.new
    @builder = Gtk::Builder.new
    @builder.add_from_file('ui.glade')

    @window = @builder.get_object('main_window')
    @window.signal_connect('destroy') { Gtk.main_quit }

    @add_button = @builder.get_object('add_button')
    @add_button.signal_connect('clicked') { add_book }

    @list_button = @builder.get_object('list_button')
    @list_button.signal_connect('clicked') { list_books }

    @window.show_all
  end

  def add_book
    title  = @builder.get_object('title_entry').text
    author = @builder.get_object('author_entry').text
    isbn   = @builder.get_object('isbn_entry').text

    @library.add_book(Book.new(title, author, isbn))
    @library.save_to_json(FILE_PATH)

    puts "Livro adicionado: #{title} por #{author} (ISBN: #{isbn})"
  end

  def list_books
    @library.list_books.each do |book|
      puts "#{book.title} - #{book.author} (#{book.isbn})"
    end
  end
end


Gtk.init
LibraryApp.new
Gtk.main
