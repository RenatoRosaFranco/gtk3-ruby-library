# frozen_string_literal: true

require 'active_record'
require_relative '../db/config'

class Book < ActiveRecord::Base
  self.table_name = 'books'

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true, uniqueness: true
end
