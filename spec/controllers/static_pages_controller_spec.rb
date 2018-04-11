require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "#home" do
  
    # 正常にレスポンスを返すこと
    it "responds successfully" do
      get :home
      expect(response).to be_success
    end
    
    #200レスポンスを返すこと
    it"returnsa200response"do
      get :home
      expect(response).to have_http_status "200"
    end
  
  end
  
end
