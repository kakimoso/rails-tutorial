require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  def sign_in(user)
    session[:user_id] = user.id
  end

  describe "#index" do
    # ログイン済み
    context "as an authenticated user" do
      before(:each) do
        @user = FactoryGirl.create(:loginuser)
      end
    
      # 正常にレスポンスを返すこと
      it "responds successfully" do
        sign_in(@user)
        get :index
        expect(response).to be_success 
      end
      
      # 200レスポンスを返すこと
      it "returns a 200 response" do
        sign_in(@user)
        get :index
        expect(response).to have_http_status "200"
      end
    end
    
    # ゲストとして
    context "as a guest" do
      # 302レスポンスを返すこと(リダイレクトされること)
      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end
      
      # サインイン画面にリダイレクトすること
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to "/login"
      end
    end
  end
  
  describe "#show" do
    # 認可されたユーザーとして
    context "as an authorized user" do
      
      before do
        @user = FactoryGirl.create(:loginuser)
        @micropost = FactoryGirl.create(:micropost)
      end
      
      # 正常にレスポンスを返すこと
      it "responds successfully" do
        sign_in @user
        get :show, params: { id: @user.id }
        expect(response).to be_success
      end
      
      # マイクロポストが表示されること
      it "display microposts" do
        sign_in @user
        get :show, params: { id: @micropost.user_id }
        expect(response).to be_success
      end
      
    end
    
    # 認可されていないユーザーとして
    context "as an unauthorized user" do
    
      before do
        @user = FactoryGirl.create(:user)
      end
      
      # # ダッシュボードにリダイレクトすること
      # it "redirects to the dashboard" do
      #   sign_in @user
      #   get :show, params: { id: @user.id }
      #   expect(response).to be_success
      # end
    
    end
  end
  
  describe"#create"do
        
    before do
      @user = FactoryGirl.create(:loginuser)
    end
    
    # 有効な入力値の場合
    context "with valid attributes" do
    
      # ユーザ登録できること 
      it "create a user" do
        user_params = FactoryGirl.attributes_for(:user)
        expect{
          post :create, params: { user: user_params }
          }.to change(User, :count).by(1)
      end

    end
    
    # 無効な入力値の場合
    context "with invalid attributes" do
      # ユーザ登録されないこと 
      it "create a user" do
        user_params = FactoryGirl.attributes_for(:user, :invalid_user)
        expect{
          post :create, params: { user: user_params }
          }.to_not change(User, :count)
      end
      
      # new テンプレートが表示されること
      it "render new page" do
        user_params = FactoryGirl.attributes_for(:user, :invalid_user)
        post :create, params: { user: user_params }
        expect(response).to render_template :new
      end

    end
    
  end
  
  describe"#update"do
    
    # 認可されたユーザーとして
    context "as an authorized user" do
      
      before do
        @user = FactoryGirl.create(:loginuser)
      end

      # ユーザを更新できること
      it "updates a user" do
          user_params = FactoryGirl.attributes_for(:user,
            name: "update name")
          sign_in @user
          patch :update, params: { id: @user.id, user: user_params }
          expect(@user.reload.name).to eq "update name"
      end

    end


    # 他のユーザとして
    context "as an other user" do
      
      before do
        @user = FactoryGirl.create(:loginuser)
        @other_user = FactoryGirl.create(:user)
      end
      
      # 他のユーザを更新できないこと
      it "does not update the user" do
        user_params = FactoryGirl.attributes_for(:user,
          name: "New Name")
        sign_in @user
        patch :update, params: { id: @other_user.id, user: user_params }
        expect(@other_user.reload.name).to eq "Example User"
      end

      # homeにリダイレクトすること
      it "redirects to home" do
        user_params = FactoryGirl.attributes_for(:user,
          name: "New Name")
        sign_in @user
        patch :update, params: { id: @other_user.id, user: user_params }
        expect(response).to redirect_to root_url
      end
      
    end
    
    # ほぼ他ユーザと同じためゲスト(未ログイン)省略

  end
  
  
  describe"#destroy"do
  
    # 管理者ユーザとして
    context "as an administrator" do
      
      before do
        @user = FactoryGirl.create(:loginuser)
        @target_user = FactoryGirl.create(:user)
      end

      # ユーザを削除できること
      it "deletes a user" do
        sign_in @user
        expect {
          delete :destroy, params: { id: @target_user.id }
          }.to change(User, :count).by(-1)
      end
    end
    
    
    # 一般ユーザーとして
    context "as an nomal user" do
      
      before do
        @user = FactoryGirl.create(:loginuser, :non_admin)
        @target_user = FactoryGirl.create(:user)
      end
    
      # ユーザを削除できないこと
      it "does not delete the user" do
        sign_in @user
        expect {
            delete :destroy, params: { id: @target_user.id }
          }.to_not change(User, :count)
      end
      
    end
    
    # ほぼ他ユーザと同じためゲスト(未ログイン)省略
    
  end
  
  # edit followは時間があったら
  
end
