# frozen_string_literal: true

require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/library.db'
)

unless ActiveRecord::Base.connection.table_exists?(:books)
  ActiveRecord::Base.connection.create_table :books do |t|
    t.string :title
    t.string :author
    t.string :isbn
    t.boolean :available, default: true

    t.timestamps
  end
end
