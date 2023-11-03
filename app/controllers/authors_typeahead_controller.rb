class AuthorsTypeaheadController < ApplicationController
  # regenerate this controller with
  # bin/rails generate hot_glue:typeahead Author 

  def index
    query = params[:query]

    @authors = Author.where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?", "%#{query.downcase}%", "%#{query.downcase}%").limit(10)

    render layout: false
  end
end
