require 'spec_helper'

describe TextDocumentsController do
	# login_admin

  # This should return the minimal set of attributes required to create a valid
  # TextDocument. As you add validations to TextDocument, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { content: "some txt",
		}
  end

   describe "GET index" do
    it "assigns all text_documents as @text_documents" do
      text_document = Fabricate :text_document, valid_attributes
      get :index, {}
      assigns(:text_documents).should eq([text_document])
    end
  end

  describe "GET show" do
    it "assigns the requested text_document as @text_document" do
      text_document = Fabricate :text_document, valid_attributes
      get :show, {:id => text_document.to_param}
      assigns(:text_document).should eq(text_document)
    end
  end

  describe "GET new" do
    it "assigns a new text_document as @text_document" do
      get :new, {}
      assigns(:text_document).should be_a_new(TextDocument)
    end
  end

  describe "GET edit" do
    it "assigns the requested text_document as @text_document" do
      text_document = Fabricate :text_document, valid_attributes
      get :edit, {:id => text_document.to_param}
      assigns(:text_document).should eq(text_document)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TextDocument" do
        expect {
          post :create, {:text_document => valid_attributes}
        }.to change(TextDocument, :count).by(1)
      end

      it "assigns a newly created text_document as @text_document" do
        post :create, {:text_document => valid_attributes}
        assigns(:text_document).should be_a(TextDocument)
        assigns(:text_document).should be_persisted
      end

      it "redirects to the created text_document" do
        post :create, {:text_document => valid_attributes}
        response.should redirect_to(text_document_url(TextDocument.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved text_document as @text_document" do
        # Trigger the behavior that occurs when invalid params are submitted
        TextDocument.any_instance.stubs(:save).returns(false)
        post :create, {:text_document => {}}
        assigns(:text_document).should be_a_new(TextDocument)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TextDocument.any_instance.stubs(:save).returns(false)
        post :create, {:text_document => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested text_document" do
        text_document = Fabricate :text_document, valid_attributes
        # Assuming there are no other text_documents in the database, this
        # specifies that the TextDocument created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        TextDocument.any_instance.expects(:update_attributes).with({'these' => 'params'})
        put :update, {:id => text_document.to_param, :text_document => {'these' => 'params'}}
      end

      it "assigns the requested text_document as @text_document" do
        text_document = Fabricate :text_document, valid_attributes
        put :update, {:id => text_document.to_param, :text_document => valid_attributes}
        assigns(:text_document).should eq(text_document)
      end

      it "redirects to the text_document" do
        text_document = Fabricate :text_document, valid_attributes
        put :update, {:id => text_document.to_param, :text_document => valid_attributes}
        response.should redirect_to(text_document_url(text_document))
      end
    end

    describe "with invalid params" do
      it "assigns the text_document as @text_document" do
        text_document = Fabricate :text_document, valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TextDocument.any_instance.stubs(:save).returns(false)
        put :update, {:id => text_document.to_param, :text_document => {}}
        assigns(:text_document).should eq(text_document)
      end

      it "re-renders the 'edit' template" do
        text_document = Fabricate :text_document, valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TextDocument.any_instance.stubs(:save).returns(false)
        put :update, {:id => text_document.to_param, :text_document => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested text_document" do
      text_document = Fabricate :text_document, valid_attributes
      expect {
        delete :destroy, {:id => text_document.to_param}
      }.to change(TextDocument, :count).by(-1)
    end

    it "redirects to the text_documents list" do
      text_document = Fabricate :text_document, valid_attributes
      delete :destroy, {:id => text_document.to_param}
      response.should redirect_to(text_documents_url)
    end
  end
	
end
