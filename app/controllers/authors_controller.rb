class AuthorsController < ApplicationController
  # regenerate this controller with
  # bin/rails generate hot_glue:scaffold Author --gd --smart-layout

  helper :hot_glue
  include HotGlue::ControllerHelper

  
  before_action :load_author, only: [:show, :edit, :update, :destroy]
  after_action -> { flash.discard }, if: -> { request.format.symbol == :turbo_stream }
  
  
  def load_author
    @author = Author.find(params[:id])
  end
  
  def load_all_authors 
    @authors = Author.page(params[:page])
    
  end

  def index
    load_all_authors
  end

  def new
    @author = Author.new()
    
  end

  def create
    modified_params = modify_date_inputs_on_params(author_params.dup, nil, []) 

      
      
    @author = Author.create(modified_params)

    if @author.save
      flash[:notice] = "Successfully created #{@author.name}"
      
      load_all_authors
      render :create
    else
      flash[:alert] = "Oops, your author could not be created. #{@hawk_alarm}"
      @action = "new"
      render :create, status: :unprocessable_entity
    end
  end



  def show
    redirect_to edit_author_path(@author)
  end

  def edit
    @action = "edit"
    render :edit
  end

  def update
    flash[:notice] = +''
    flash[:alert] = nil
    
    modified_params = modify_date_inputs_on_params(update_author_params.dup, nil, []) 

    
      
    
    if @author.update(modified_params)
    
      
      flash[:notice] << "Saved #{@author.name}"
      flash[:alert] = @hawk_alarm if @hawk_alarm
      render :update
    else
      flash[:alert] = "Author could not be saved. #{@hawk_alarm}"
      @action = "edit"
      render :update, status: :unprocessable_entity
    end
  end

  def destroy
    
    begin
      @author.destroy
      flash[:notice] = 'Author successfully deleted'
    rescue StandardError => e
      flash[:alert] = 'Author could not be deleted'
    end 
    load_all_authors
  end

  def author_params
    params.require(:author).permit([:first_name, :last_name])
  end

  def update_author_params
    params.require(:author).permit([:first_name, :last_name])
  end

  def namespace
    
  end
end


