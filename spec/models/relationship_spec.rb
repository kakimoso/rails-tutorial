require 'rails_helper'

RSpec.describe Relationship, type: :model do
  
  before(:each) do
    user = FactoryGirl.create(:loginuser)
    other_user = FactoryGirl.create(:user)
    @relationship = Relationship.new(follower_id: user.id,
                                    followed_id: other_user.id)
  end
  
  # モデルが有効であること
  it "should be valid" do
    @relationship.valid?
    expect(@relationship).to be_valid
  end
  
  # follower_idがあること
  it "should have follower_id" do
    @relationship.follower_id = nil
    expect(@relationship).to_not be_valid
  end
  
  # followed_idがあること
  it "should have followed_id" do
    @relationship.followed_id = nil
    expect(@relationship).to_not be_valid
  end
  
end
