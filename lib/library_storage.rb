# frozen_string_literal: true

module LibraryStorage
  def self.save_to_json(books, file_path)
    File.open(file_path, 'w') do |file|
      json_data = books.map do |book|
        {
          title: book.title,
          author: book.author,
          isbn: book.isbn,
          available: book.available
        }
      end
      file.write(JSON.pretty_generate(json_data)) # Correção feita aqui
    end
  end

  def self.load_from_json(file_path)
    return [] unless File.exist?(file_path)

    json_data = JSON.parse(File.read(file_path))
    json_data.map do |book_data|
      Book.new(book_data['title'], book_data['author'], book_data['isbn']).tap do |book|
        book.available = book_data['available']
      end
    end
  end
end
