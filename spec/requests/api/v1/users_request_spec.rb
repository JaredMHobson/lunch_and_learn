require 'rails_helper'

describe "Users API" do
  describe 'User Create' do
    it "creates a user and returns their name, email and api key in JSON" do
      user_params = {
        name: 'random name',
        email: 'randomemail@email.com',
        password: 'abc123',
        password_confirmation: 'abc123'
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", params: JSON.generate(user_params), headers: headers

      user = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(user).to have_key(:id)
      expect(user[:id]).to be_an(String)

      expect(user).to have_key(:type)
      expect(user[:type]).to eq('user')

      expect(user[:attributes]).to have_key(:name)
      expect(user[:attributes][:name]).to be_an(String)
      expect(user[:attributes][:name]).to eq('random name')

      expect(user[:attributes]).to have_key(:email)
      expect(user[:attributes][:email]).to be_an(String)
      expect(user[:attributes][:email]).to eq('randomemail@email.com')

      expect(user[:attributes]).to have_key(:api_key)
      expect(user[:attributes][:api_key]).to be_an(String)

      last_user = User.last

      expect(last_user.name).to eq('random name')
      expect(last_user.email).to eq('randomemail@email.com')
      expect(last_user.authenticate('abc123')).to eq(last_user)
    end

    it 'returns a status of 422 and an appropriate error message if password confirmation doesnt match password' do
      user_params = {
        name: 'random name',
        email: 'randomemail@email.com',
        password: 'abc123',
        password_confirmation: 'def456'
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", params: JSON.generate(user_params), headers: headers

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      expect(data[:errors].first[:status]).to eq('422')
      expect(data[:errors].first[:title]).to eq("Validation failed: Password confirmation doesn't match Password")
    end

    it 'returns a status of 422 and an appropriate error message if the email has already been taken' do
      user_params = {
        name: 'random name',
        email: 'randomemail@email.com',
        password: 'abc123',
        password_confirmation: 'abc123'
      }

      User.create!(user_params)

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", params: JSON.generate(user_params), headers: headers

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      expect(data[:errors].first[:status]).to eq('422')
      expect(data[:errors].first[:title]).to eq("Validation failed: Email has already been taken")
    end
  end
end
