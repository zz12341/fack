require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/assistants", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Assistant. As you add validations to Assistant, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Assistant.create! valid_attributes
      get assistants_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      assistant = Assistant.create! valid_attributes
      get assistant_url(assistant)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_assistant_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      assistant = Assistant.create! valid_attributes
      get edit_assistant_url(assistant)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Assistant" do
        expect {
          post assistants_url, params: { assistant: valid_attributes }
        }.to change(Assistant, :count).by(1)
      end

      it "redirects to the created assistant" do
        post assistants_url, params: { assistant: valid_attributes }
        expect(response).to redirect_to(assistant_url(Assistant.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Assistant" do
        expect {
          post assistants_url, params: { assistant: invalid_attributes }
        }.to change(Assistant, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post assistants_url, params: { assistant: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested assistant" do
        assistant = Assistant.create! valid_attributes
        patch assistant_url(assistant), params: { assistant: new_attributes }
        assistant.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the assistant" do
        assistant = Assistant.create! valid_attributes
        patch assistant_url(assistant), params: { assistant: new_attributes }
        assistant.reload
        expect(response).to redirect_to(assistant_url(assistant))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        assistant = Assistant.create! valid_attributes
        patch assistant_url(assistant), params: { assistant: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested assistant" do
      assistant = Assistant.create! valid_attributes
      expect {
        delete assistant_url(assistant)
      }.to change(Assistant, :count).by(-1)
    end

    it "redirects to the assistants list" do
      assistant = Assistant.create! valid_attributes
      delete assistant_url(assistant)
      expect(response).to redirect_to(assistants_url)
    end
  end
end
