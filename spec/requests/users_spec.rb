require 'rails_helper'

RSpec.describe "Users", :type => :request do
  let(:default_params) do
    {format: :json}
  end

  describe "GET /api/v1/users" do
    it "returns users" do
      user = create(:user)
      get api_users_path, default_params
      expect(response.body).to be_json_as([{
        'id' => user.id,
        'name' => user.name,
        'url' => api_user_url(user, format: :json),
      }])
      expect(response.status).to be(200)
    end
  end

  describe "GET /api/v1/users/1" do
    it "return a user" do
      user = create(:user)
      get api_user_path(user), default_params
      expect(response.body).to be_json_as({
        'id' => user.id,
        'name' => user.name,
        'updated_at' => user.updated_at.as_json,
        'created_at' => user.created_at.as_json,
      })
      expect(response.status).to be(200)
    end
  end

  describe "POST /api/v1/users" do
    it "creates a new user" do
      post api_users_path, default_params.merge(user: {name: 'Bob'})
      expect(User.last.attributes).to include(
        'name' => 'Bob',
      )
      expect(response.status).to be(201)
    end
  end
end
