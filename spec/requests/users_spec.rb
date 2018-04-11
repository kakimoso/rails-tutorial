require 'rails_helper'

RSpec.describe "User", type: :request do
  
  # include_context "project setup"
  # let(:admin_user){FactoryGirl.create(:loginuser)}
  
  shared_context "project setup" do

    let(:admin_user){FactoryGirl.create(:loginuser)}
    let(:user){FactoryGirl.create(:user)}

  end

  # ログインする
  def sign_in(user)
    post login_path, params: { 
      session:{ email:user.email,
      password:user.password }
    }
  end

  # ここにログインテストを書くのはよい？
  # アクセス制御に引っかからないようにするためログインが必要なので、
  # ログイン機能自体をテストしておく
  describe "login", focus: true do
    
    include_context 'project setup'
    
    # ログインテスト
    it "success login" do
      sign_in(admin_user)
      get users_path
      expect(response).to be_success
    end
    
    # 非ログイン時のアクセス制御確認テスト
    it "failed access" do
      get users_path
      expect(response).to_not be_success
    end
    
  end


  describe "GET /users" do
    
    include_context 'project setup'
    
    # ログイン済みのユーザとして
    context "as logged in user" do

      # ログインする    
      before(:each) do
        sign_in(admin_user)
      end
      
      # 正常にレスポンスを返すこと
      it "respond successfully" do
        get users_path
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

    end

    # ゲストとして     
    context "as guest" do
      
      # サインイン画面にリダイレクトすること
      it "redirects to the login page" do
        get users_path
        expect(response).to redirect_to login_url
      end
    end
    
  end
end
