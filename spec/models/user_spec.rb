require 'rails_helper'

RSpec.describe User, type: :model do
  
  before(:each) do
    @user = FactoryGirl.build(:user)
  end
  
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid 
  end
  
  # 名前、メールアドレス、パスワードがあれば有効であること
  it "is valid with a name, email, password, and password_confirmation" do
    expect(@user).to be_valid
  end
  
  # 名前がなければ無効であること
  it { is_expected.to validate_presence_of :name }
  
  # メールアドレスなければ無効であること
  it "is invalid without a email" do
    
    skip "no longer necessary"
    
    @user.email = nil
    @user.valid?
    expect(@user.errors[:email]).to include("can't be blank")
  end
  
  # 名前が長すぎた場合無効であること
  it "is invalid with too long name" do
    @user.name = "a" * 51
    @user.valid?
    expect(@user.errors[:name]).to include(/.*is too long.*/)
  end
  
  # メールアドレスが長すぎた場合無効であること
  it "is invalid with too long email" do
    @user.email = "a" * 244 + "@example.com"
    @user.valid?
    expect(@user.errors[:email]).to include(/.*is too long.*/)
  end
  
  # 無効なメールアドレスの場合無効となること
  it "is invalid with invalid address" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      @user.valid?
      expect(@user.errors[:email]).to include(/.*invalid.*/)
    end
  end
  
  # メールアドレスが一意であること
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  
  # パスワードが空白でないこと
  it "has password(non blank)" do
    @user.password = @user.password_confirmation = " " * 6 
    @user.valid?
    expect(@user.errors[:password]).to include("can't be blank")
  end  
  
  # パスワードは最低限の長さがあること
  it "has password which has enough length" do
    @user.password = @user.password_confirmation = "a" * 5 
    @user.valid?
    expect(@user.errors[:password]).to include(/.*is too short.*/)
  end
  
  # 記憶トークンがnilの場合にauthenticated?がfalseを返すこと
  it "returns false if remember_token is nil" do
    returned_bool = @user.authenticated?(:remember, '')
    expect(returned_bool).to eq(false)
  end
  
end
