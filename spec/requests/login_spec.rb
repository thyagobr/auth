require "rails_helper"

describe "POST /api/login", type: :request do
  let(:token) { "NEKJOT" }
  let(:connected_app) { App.create(name: "App", identifier: "app", token: token) }
  let!(:user) { User.create!(app: connected_app, nickname: "thyago", email: "thyago@auth.com", password: "password", password_confirmation: "password") }

  it "logs the user in if authentication is okay" do
    post "/api/login",
      headers: {
        "Content-Type": "application/json",
        "Authentication": "Bearer #{token}"
      },
      params: {
        email: "thyago@auth.com",
        password: "password"
      }.to_json
      
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to eq({
        id: user.id,
        nickname: "thyago",
        email: "thyago@auth.com",
        created_at: user.created_at.to_fs(:db),
        updated_at: user.updated_at.to_fs(:db)
      })
      expect(response.status).to eq 200
  end

  it "fails if password is wrong" do
    post "/api/login",
      headers: {
        "Content-Type": "application/json",
        "Authentication": "Bearer #{token}"
      },
      params: {
        email: "thyago@auth.com",
        password: "wrong_password"
      }.to_json
      
      expect(response.status).to eq 401
  end

  it "throws an error if password is wrong" do
    post "/api/login",
      headers: {
        "Content-Type": "application/json",
        "Authentication": "Bearer #{token}"
      },
      params: {
        email: "thyago@auth.com",
        password: "wrong_password"
      }.to_json
      
      expect(response.status).to eq 401
  end
end

