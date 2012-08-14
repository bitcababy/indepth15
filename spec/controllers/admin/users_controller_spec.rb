require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe Admin::UsersController do
	login_admin

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { honorific: "Mr",
			first_name: "Brad",
			last_name: "Pitt",
			login: "pittb",
			email: "bittb@example.com"
		}
  end

   describe "GET index" do
    it "assigns all admin_users as @users" do
      user = Fabricate :user, valid_attributes
      get :index, {}
			pending "Unfinished test"
      assigns(:users).should eq([user])
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = Fabricate :user, valid_attributes
      get :show, {:id => user.to_param}
      assigns(:user).should eq(user)
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new, {}
      assigns(:user).should be_a_new(User)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      user = Fabricate :user, valid_attributes
      get :edit, {:id => user.to_param}
      assigns(:user).should eq(user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the created user" do
        post :create, {:user => valid_attributes}
        response.should redirect_to(admin_user_url(User.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stubs(:save).returns(false)
        post :create, {:user => {}}
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stubs(:save).returns(false)
        post :create, {:user => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        user = Fabricate :user, valid_attributes
        # Assuming there are no other users in the database, this
        # specifies that the User created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        User.any_instance.expects(:update_attributes).with({'these' => 'params'})
        put :update, {:id => user.to_param, :user => {'these' => 'params'}}
      end

      it "assigns the requested user as @user" do
        user = Fabricate :user, valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}
        assigns(:user).should eq(user)
      end

      it "redirects to the user" do
        user = Fabricate :user, valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}
        response.should redirect_to(admin_user_url(user))
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        user = Fabricate :user, valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stubs(:save).returns(false)
        put :update, {:id => user.to_param, :user => {}}
        assigns(:user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        user = Fabricate :user, valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stubs(:save).returns(false)
        put :update, {:id => user.to_param, :user => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      user = Fabricate :user, valid_attributes
      expect {
        delete :destroy, {:id => user.to_param}
      }.to change(User, :count).by(-1)
    end

    it "redirects to the admin_users list" do
      user = Fabricate :user, valid_attributes
      delete :destroy, {:id => user.to_param}
      response.should redirect_to(admin_users_url)
    end
  end

end
