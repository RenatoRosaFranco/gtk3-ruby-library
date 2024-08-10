# frozen_string_literal: true

require 'gtk3'

class LibraryUI
  attr_reader :builder, :window, :add_button, :list_button,
              :remove_button, :update_button, :book_tree_view,
              :title_entry, :author_entry, :isbn_entry,
              :book_list_store

  def initialize
    @builder = Gtk::Builder.new
    @builder.add_from_file('ui.glade')

    @window = @builder.get_object('main_window')
    @window.signal_connect('destroy') { Gtk.main_quit }

    @add_button = @builder.get_object('add_button')
    @list_button = @builder.get_object('list_button')
    @remove_button = @builder.get_object('remove_button')
    @update_button = @builder.get_object('update_button')

    @title_entry = @builder.get_object('title_entry')
    @author_entry = @builder.get_object('author_entry')
    @isbn_entry = @builder.get_object('isbn_entry')

    @book_tree_view = @builder.get_object('book_tree_view')
    @book_list_store = Gtk::ListStore.new(Integer, String, String, String)

    setup_tree_view_columns
    @book_tree_view.model = @book_list_store
  end

  def setup_tree_view_columns
    renderer = Gtk::CellRendererText.new

    col_id     = Gtk::TreeViewColumn.new("ID",     renderer, text: 0)
    col_title  = Gtk::TreeViewColumn.new("Title",  renderer, text: 1)
    col_author = Gtk::TreeViewColumn.new("Author", renderer, text: 2)
    col_isbn   = Gtk::TreeViewColumn.new("ISBN",   renderer, text: 3)

    @book_tree_view.append_column(col_id)
    @book_tree_view.append_column(col_title)
    @book_tree_view.append_column(col_author)
    @book_tree_view.append_column(col_isbn)
  end
end
