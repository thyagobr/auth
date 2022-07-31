require "rails_helper"

describe AuthenticateUser, type: :service do
  let(:connected_app) { App.create(name: "App", identifier: "app", token: "token") }
  let!(:user) { User.create!(app: connected_app, nickname: "thyago", email: "thyago@auth.com", password: "password", password_confirmation: "password") }

  context "with all correct params" do
    let(:input) do
      {
        email: "thyago@auth.com",
        password: "password"
      }
    end

    it "logs the user in if authentication is okay" do
      output = AuthenticateUser.call(input)
      expect(output.message).to eq({
        id: user.id,
        nickname: "thyago",
        email: "thyago@auth.com",
        created_at: user.created_at.to_fs(:db),
        updated_at: user.updated_at.to_fs(:db)
      })
      expect(output).to be_success
    end
  end

  context "with missing email param" do
    let(:input) do
      {
        password: "password"
      }
    end

    it "returns failure message" do
      output = AuthenticateUser.call(input)
      expect(output.message).to eq("email is missing")
    end
  end

  context "with missing password param" do
    let(:input) do
      {
        email: "thyago@auth.com"
      }
    end

    it "returns failure message" do
      output = AuthenticateUser.call(input)
      expect(output.message).to eq("password is missing")
    end
  end

  context "with wrong email" do
    let(:input) do
      {
        email: "wrong@auth.com",
        password: "password"
      }
    end

    it "returns failure message" do
      output = AuthenticateUser.call(input)
      expect(output.message).to eq("user not found")
    end
  end

  context "with wrong password" do
    let(:input) do
      {
        email: "thyago@auth.com",
        password: "wrong_password"
      }
    end

    it "returns failure message" do
      output = AuthenticateUser.call(input)
      expect(output.message).to eq("authentication failed")
    end
  end
end
