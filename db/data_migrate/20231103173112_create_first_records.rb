class CreateFirstRecords < ActiveRecord::Migration[7.0]
  def change

    100.times{FactoryBot.create(:author) }
    author_count = Author.count
    1000.times{FactoryBot.create(:book, author: Author.all[rand(author_count)]) }

  end
end
