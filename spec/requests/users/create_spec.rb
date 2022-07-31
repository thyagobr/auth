require "rails_helper"

describe "POST /api/users", type: :request do
  let(:token) { "NEKJOT" }

  it "creates a new user" do
    post "/api/users",
      headers: {
        "Content-Type": "application/json",
        "Authentication": "Bearer #{token}"
      },
      params: {
        nickname: "thyago",
        email: "thyago@auth.com",
        password: "password"
      }

      parsed_response = JSON.parse(response.body)
      user = User.last
      expect(parsed_response).to eq({
        id: user.id,
        nickname: "thyago",
        email: "thyago@auth.com",
        created_at: user.created_at,
        updated_at: user.updated_at
      })
      expect(response.status).to eq 200
  end

  it "generates a random nickname when it is missing from the params" do
    post "/api/users",
      headers: {
        "Content-Type": "application/json",
        "Authentication": "Bearer #{token}"
      },
      params: {
        email: "thyago@auth.com",
        password: "password"
      }

      parsed_response = JSON.parse(response.body)
      user = User.last
      expect(parsed_response[:nickname]).to be_present
      expect(response.status).to eq 200
  end

  it "returns an error when email or password are missing from the params" do
    post "/api/users",
      headers: {
        "Content-Type": "application/json",
        "Authentication": "Bearer #{token}"
      },
      params: {
        nickname: "thyago"
      }

      parsed_response = JSON.parse(response.body)
      expect(User.count).to be_zero
      expect(parsed_response).to eq([{
        error: "email is required",
        error: "password is required"
      }])
      expect(response.status).to eq 422
  end
end
