# frozen_string_literal: true

module BookOperations
  def add_book
    title  = @ui.title_entry.text
    author = @ui.author_entry.text
    isbn   = @ui.isbn_entry.text

    # Crie um novo livro com um hash de atributos
    book = Book.new(title: title, author: author, isbn: isbn)

    if book.save
      update_book_list
      clear_input_fields
      puts "Livro adicionado: #{title} por #{author} (ISBN: #{isbn})"
    else
      puts "Erro ao adicionar o livro: #{book.errors.full_messages.join(', ')}"
    end
  end

  def update_book
    return unless @selected_book_id

    title  = @ui.title_entry.text
    author = @ui.author_entry.text
    isbn   = @ui.isbn_entry.text

    book = @library.find_book_by_id(@selected_book_id)
    if book
      if book.update(title: title, author: author, isbn: isbn)
        update_book_list
        clear_input_fields
        puts "Livro atualizado: ID #{@selected_book_id}"
      else
        puts "Erro ao atualizar o livro: #{book.errors.full_messages.join(', ')}"
      end
    end
  end

  def remove_book
    return unless @selected_book_id

    if @library.remove_book_by_id(@selected_book_id)
      update_book_list
      clear_input_fields
      puts "Livro removido: ID #{@selected_book_id}"
      @selected_book_id = nil
    else
      puts "Erro ao remover o livro"
    end
  end

  private

  def clear_input_fields
    @ui.title_entry.text = ''
    @ui.author_entry.text = ''
    @ui.isbn_entry.text = ''
  end
end
