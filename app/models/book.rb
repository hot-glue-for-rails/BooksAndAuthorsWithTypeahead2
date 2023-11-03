class Book < ApplicationRecord
  belongs_to :author

  def name
    "#{title} by #{author.name}"
  end
end
