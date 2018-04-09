require 'rails_helper'

RSpec.feature "Microposts", type: :feature do
  # ユーザは新しいマイクロポストを投稿する
  scenario "user posts new micropost" do
    user = FactoryGirl.create(:user)
    
    visit root_path
    click_link "Log in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    
    expect {
      click_link "Home"
      fill_in "micropost_content", with: "Test Content"
      click_button "Post"
      
      expect(page).to have_content "Micropost created!"
      expect(page).to have_content "Test Content"
    }.to change(Micropost, :count).by(1)
  end
end
