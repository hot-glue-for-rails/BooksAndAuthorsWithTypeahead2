require 'rails_helper'

describe 'interaction for BooksController' do
  include HotGlue::ControllerHelper
  include ActionView::RecordIdentifier

  # HOTGLUE-SAVESTART
  # HOTGLUE-END
  
  let!(:author1) {create(:author)}

  let!(:book1) {
    book = create(:book , 
                          author: author1, 
                          title: FFaker::Movie.title )

    book.save!
    book
  }
  
  describe "index" do
    it "should show me the list" do
      visit books_path
      
      expect(page).to have_content(book1.title)
    end
  end

  describe "new & create" do
    it "should create a new Book" do
      visit books_path
      click_link "New Book"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Book")]')
      author_id_selector = find("[name='book[author_id]']").click 
      author_id_selector.first('option', text: author1.name).select_option
      new_title = FFaker::Movie.title 
      find("[name='book[title]']").fill_in(with: new_title)
      click_button "Save"
      expect(page).to have_content("Successfully created")

       expect(page).to have_content(author1.name)
      expect(page).to have_content(new_title)
    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit books_path
      find("a.edit-book-button[href='/books/#{book1.id}/edit']").click

      expect(page).to have_content("Editing #{book1.name.squish || "(no name)"}")
      author_id_selector = find("[name='book[author_id]']").click 
      author_id_selector.first('option', text: author1.name).select_option
      new_title = FFaker::Movie.title 
      find("[name='book[title]']").fill_in(with: new_title)
      click_button "Save"
      within("turbo-frame#__#{dom_id(book1)} ") do
         expect(page).to have_content(author1.name)
       expect(page).to have_content(new_title)
      end
    end
  end 

  describe "destroy" do
    it "should destroy" do
      visit books_path
      accept_alert do
        find("form[action='/books/#{book1.id}'] > input.delete-book-button").click
      end
      expect(page).to_not have_content(book1.name)
      expect(Book.where(id: book1.id).count).to eq(0)
    end
  end
end

