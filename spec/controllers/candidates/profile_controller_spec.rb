require 'rails_helper'

RSpec.describe Candidates::ProfileController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #contact_data" do
    it "returns http success" do
      get :contact_data
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #languages" do
    it "returns http success" do
      get :languages
      expect(response).to have_http_status(:success)
    end
  end

end
