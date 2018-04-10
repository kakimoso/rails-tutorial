require 'rails_helper'

RSpec.feature "Microposts", type: :feature do

  
  # ユーザは新しいマイクロポストを投稿する
  scenario "user posts new micropost" do
    user = FactoryGirl.create(:user)
    login_as user
    expect {
      content = "Test Content"
      post_micropost(content)
      expect_post_micropst(content)
    }.to change(Micropost, :count).by(1)
    
  end
  
  def login_as(user)
    visit root_path
    click_link "Log in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end
  
  def post_micropost(content)
    click_link "Home"
    fill_in "micropost_content", with: content
    click_button "Post"
  end
  
  def expect_post_micropst(content)
    aggregate_failures do
      expect(page).to have_content "Micropost created!"
      expect(page).to have_content content
    end
  end
  
end
