class BooksController < ApplicationController
  # regenerate this controller with
  # bin/rails generate hot_glue:scaffold Book --modify='author_id{typeahead}' --gd --smart-layout

  helper :hot_glue
  include HotGlue::ControllerHelper

  
  before_action :load_book, only: [:show, :edit, :update, :destroy]
  after_action -> { flash.discard }, if: -> { request.format.symbol == :turbo_stream }
  
  
  def load_book
    @book = Book.find(params[:id])
  end
  
  def load_all_books 
    @books = Book.includes(:author).page(params[:page])
    
  end

  def index
    load_all_books
  end

  def new
    @book = Book.new()
    
  end

  def create
    modified_params = modify_date_inputs_on_params(book_params.dup, nil, []) 

      
      
    @book = Book.create(modified_params)

    if @book.save
      flash[:notice] = "Successfully created #{@book.name}"
      
      load_all_books
      render :create
    else
      flash[:alert] = "Oops, your book could not be created. #{@hawk_alarm}"
      @action = "new"
      render :create, status: :unprocessable_entity
    end
  end



  def show
    redirect_to edit_book_path(@book)
  end

  def edit
    @action = "edit"
    render :edit
  end

  def update
    flash[:notice] = +''
    flash[:alert] = nil
    
    modified_params = modify_date_inputs_on_params(update_book_params.dup, nil, []) 

    
      
    
    if @book.update(modified_params)
    
      
      flash[:notice] << "Saved #{@book.name}"
      flash[:alert] = @hawk_alarm if @hawk_alarm
      render :update
    else
      flash[:alert] = "Book could not be saved. #{@hawk_alarm}"
      @action = "edit"
      render :update, status: :unprocessable_entity
    end
  end

  def destroy
    
    begin
      @book.destroy
      flash[:notice] = 'Book successfully deleted'
    rescue StandardError => e
      flash[:alert] = 'Book could not be deleted'
    end 
    load_all_books
  end

  def book_params
    params.require(:book).permit([:author_id, :title])
  end

  def update_book_params
    params.require(:book).permit([:author_id, :title])
  end

  def namespace
    
  end
end


