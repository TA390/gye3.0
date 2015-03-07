require 'rails_helper'

RSpec.describe "VolunteersSignups", :type => :request do
  describe "GET /volunteers_signups" do
    it "works! (now write some real specs)" do
      get volunteers_signups_path
      expect(response.status).to be(200)
    end
  end
end
