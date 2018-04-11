require 'rails_helper'

RSpec.describe Relationship, type: :model, focus: true do
  
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
  
end
