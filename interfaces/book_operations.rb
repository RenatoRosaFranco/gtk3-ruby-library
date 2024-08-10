module BookOperations
  def add_book
    title  = @ui.title_entry.text
    author = @ui.author_entry.text
    isbn   = @ui.isbn_entry.text

    @library.add_book(Book.new(title, author, isbn))
    @library.save_to_json

    update_book_list
    clear_input_fields

    puts "Livro adicionado: #{title} por #{author} (ISBN: #{isbn})"
  end

  def update_book
    return unless @selected_book_id

    title  = @ui.title_entry.text
    author = @ui.author_entry.text
    isbn   = @ui.isbn_entry.text

    book = @library.find_book_by_id(@selected_book_id)
    if book
      book.title = title
      book.author = author
      book.isbn = isbn
      @library.save_to_json
      update_book_list
      clear_input_fields
      puts "Livro atualizado: ID #{@selected_book_id}"
    end
  end

  def remove_book
    return unless @selected_book_id

    @library.remove_book_by_id(@selected_book_id)
    @library.save_to_json
    update_book_list
    clear_input_fields
    puts "Livro removido: ID #{@selected_book_id}"
    @selected_book_id = nil
  end

  private

  def clear_input_fields
    @ui.title_entry.text = ''
    @ui.author_entry.text = ''
    @ui.isbn_entry.text = ''
  end
end
