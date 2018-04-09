require 'rails_helper'

RSpec.describe Micropost, type: :model do
  
  before(:each) do
    @user = User.create(name: "Example User", email: "user@example.com",
                     password:"foobar",password_confirmation:"foobar")
    @m_post = @user.microposts.build(content:"example content")
  end
  
  # ユーザIDとコンテンツがあれば有効であること
  it "is valid with user_id, content" do
    expect(@m_post).to be_valid
  end
  
  # ユーザIDがあること
  it "has user_id" do
    @m_post.user_id = nil
    @m_post.valid?
    expect(@m_post.errors[:user_id]).to include("can't be blank")
  end
  
  # コンテンツがあること
  it "has content" do
    @m_post.content = "  "
    @m_post.valid?
    expect(@m_post.errors[:content]).to include("can't be blank")
  end
  
  # コンテンツは140字以内であること
  it "has content which has at most 140 characters" do
    @m_post.content = "a" * 141
    @m_post.valid?
    expect(@m_post).to_not be_valid
  end
  
  # マイクロポストは新着順に取得できること
  # テストデータが絡むため飛ばす
  
end
