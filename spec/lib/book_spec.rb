# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/book'

RSpec.describe Book do
  let(:book) { Book.new('The Hobbit', 'J.R.R Tolkien', '978-0-395-19395-8') }

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
    before { book.title = 'The Lord of the Rings' }

    it 'allows reading and writing for :title' do
      expect(book.title).to eq('The Lord of the Rings')
    end
  end

  describe '#author' do
    before { book.author = 'George R.R Martin' }

    it 'allows reading and writing for :author' do
      expect(book.author).to eq('George R.R Martin')
    end
  end

  describe '#isbn' do
    before { book.isbn = '978-0-395-19395-7' }

    it 'allows reading and writing for :isbn' do
      expect(book.isbn).to eq('978-0-395-19395-7')
    end
  end

  describe '#available' do
    before { book.available = false }

    it 'allows reading and writing for :available' do
      expect(book.available).to be false
    end
  end
end
