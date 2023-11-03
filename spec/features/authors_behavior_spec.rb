require 'rails_helper'

describe 'interaction for AuthorsController' do
  include HotGlue::ControllerHelper
  include ActionView::RecordIdentifier

    # HOTGLUE-SAVESTART
  # HOTGLUE-END
  


  let!(:author1) {
    author = create(:author , 
                          first_name: FFaker::Movie.title, 
                          last_name: FFaker::Movie.title )

    author.save!
    author
  }
  
  describe "index" do
    it "should show me the list" do
      visit authors_path
      expect(page).to have_content(author1.first_name)
      expect(page).to have_content(author1.last_name)
    end
  end

  describe "new & create" do
    it "should create a new Author" do
      visit authors_path
      click_link "New Author"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Author")]')
      new_first_name = FFaker::Movie.title 
      find("[name='author[first_name]']").fill_in(with: new_first_name)
      new_last_name = FFaker::Movie.title 
      find("[name='author[last_name]']").fill_in(with: new_last_name)
      click_button "Save"
      expect(page).to have_content("Successfully created")

      expect(page).to have_content(new_first_name)
      expect(page).to have_content(new_last_name)
    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit authors_path
      find("a.edit-author-button[href='/authors/#{author1.id}/edit']").click

      expect(page).to have_content("Editing #{author1.name.squish || "(no name)"}")
      new_first_name = FFaker::Movie.title 
      find("[name='author[first_name]']").fill_in(with: new_first_name)
      new_last_name = FFaker::Movie.title 
      find("[name='author[last_name]']").fill_in(with: new_last_name)
      click_button "Save"
      within("turbo-frame#__#{dom_id(author1)} ") do
        expect(page).to have_content(new_first_name)
       expect(page).to have_content(new_last_name)
      end
    end
  end 

  describe "destroy" do
    it "should destroy" do
      visit authors_path
      accept_alert do
        find("form[action='/authors/#{author1.id}'] > input.delete-author-button").click
      end
      expect(page).to_not have_content(author1.name)
      expect(Author.where(id: author1.id).count).to eq(0)
    end
  end
end

