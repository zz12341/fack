require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:library) { Library.create!(name: 'My Library', user:) }

  let(:valid_attributes) { { question: 'Sample Question', answer: 'Sample Answer', library_id: library.id } }
  let(:invalid_attributes) { { question: '', answer: '', library_id: nil } }

  before do
    allow_any_instance_of(QuestionsController).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      Question.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Question' do
        expect do
          post :create, params: { question: valid_attributes }
        end.to change(Question, :count).by(1)
      end

      it 'redirects to the created question' do
        post :create, params: { question: valid_attributes }
        expect(response).to redirect_to(Question.last)
      end
    end

    context 'with invalid params' do
      it 'fails to create' do
        post :create, params: { question: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested question' do
      question = Question.create! valid_attributes
      expect do
        delete :destroy, params: { id: question.to_param }
      end.to change(Question, :count).by(-1)
    end
  end
end
