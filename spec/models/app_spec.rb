require "rails_helper"

describe App, type: :model do
  context "validations" do
    it "has a secure token when saved" do
      app = App.create!(name: "App", identifier: "app")
      expect(app.token).to_not be_blank
    end
  end
end
