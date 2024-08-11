# frozen_string_literal: true

require 'rspec'
require 'active_record'
require_relative '../../lib/book'

RSpec.describe Book do
  let(:book) { Book.create(title: 'The Hobbit', author: 'J.R.R Tolkien', isbn: '978-0-395-19395-8') }

  describe '#initialize' do
    it 'initializes with a title, author, and isbn' do
      expect(book.title).to eq('The Hobbit')
      expect(book.author).to eq('J.R.R Tolkien')
      expect(book.isbn).to eq('978-0-395-19395-8')
    end

    it 'is available by default' do
      expect(book.available).to be true
    end
  end

  describe '#title' do
    it 'allows reading and writing for :title' do
      book.update(title: 'The Lord of the Rings')
      expect(book.title).to eq('The Lord of the Rings')
    end
  end

  describe '#author' do
    it 'allows reading and writing for :author' do
      book.update(author: 'George R.R Martin')
      expect(book.author).to eq('George R.R Martin')
    end
  end

  describe '#isbn' do
    it 'allows reading and writing for :isbn' do
      book.update(isbn: '978-0-395-19395-7')
      expect(book.isbn).to eq('978-0-395-19395-7')
    end
  end

  describe '#available' do
    it 'allows reading and writing for :available' do
      book.update(available: false)
      expect(book.available).to be false
    end
  end
end
