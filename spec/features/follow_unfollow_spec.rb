require'rails_helper'

RSpec.feature"FollowUnfollow",type: :feature do

  # # ユーザがユーザをフォローする・フォロー解除する
  # scenario "user toggles a task", js: true do
  #   user = FactoryGirl.create(:user)
  #   other_user = FactoryGirl.create(:loginuser)
    
  #   visit root_path
  #   click_link "Log in"
  #   fill_in "Email", with: user.email
  #   fill_in "Password", with: user.password
  #   click_button "Log in"
    
  #   visit user_path(other_user)
  #   expect(response).to render_template('show')

  # end

end