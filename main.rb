require 'gtk3'

require_relative 'lib/library'
require_relative 'lib/book'

require_relative 'interfaces/book_operations'
require_relative 'ui/library_ui'
class LibraryApp
  include BookOperations

  def initialize
    @library = Library.new
    @ui = LibraryUI.new

    setup_signals

    update_book_list

    @ui.window.show_all
  end

  def list_books
    update_book_list
  end

  private

  def setup_signals
    @ui.add_button.signal_connect('clicked') { add_book }
    @ui.list_button.signal_connect('clicked') { list_books }
    @ui.remove_button.signal_connect('clicked') { remove_book }
    @ui.update_button.signal_connect('clicked') { update_book }
    @ui.book_tree_view.signal_connect('cursor_changed') { on_book_selected }
    @ui.book_tree_view.selection.signal_connect('changed') { on_selection_changed }
  end

  def update_book_list
    @ui.book_list_store.clear
    @library.list_books.each do |book|
      iter = @ui.book_list_store.append
      iter[0] = book.id.to_s
      iter[1] = book.title
      iter[2] = book.author
      iter[3] = book.isbn
    end
  end

  def on_book_selected
    selection = @ui.book_tree_view.selection
    if iter = selection.selected
      @selected_book_id = iter[0]
      @ui.title_entry.text = iter[1]
      @ui.author_entry.text = iter[2]
      @ui.isbn_entry.text = iter[3]
    end
  end

  def on_selection_changed
    selection = @ui.book_tree_view.selection
    if !selection.selected
      @selected_book_id = nil
      clear_input_fields
    end
  end

  def clear_input_fields
    @ui.title_entry.text = ''
    @ui.author_entry.text = ''
    @ui.isbn_entry.text = ''
  end
end

Gtk.init
LibraryApp.new
Gtk.main
