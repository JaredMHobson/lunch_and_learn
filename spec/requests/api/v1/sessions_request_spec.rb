require 'rails_helper'

RSpec.describe "Sessions API", type: :request do
  describe "Sessions Create" do
    it "returns a users data when passed the correct email and password" do
      user_params = {
        name: 'random name',
        email: 'randomemail@email.com',
        password: 'abc123',
        password_confirmation: 'abc123'
      }

      User.create!(user_params)

      session_params = {
        email: 'randomemail@email.com',
        password: 'abc123',
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/sessions", params: JSON.generate(session_params), headers: headers

      user = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

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
    end

    it "returns a status of 400 and an appropriate, secure error message if an incorrect password is sent" do
      user_params = {
        name: 'random name',
        email: 'randomemail@email.com',
        password: 'abc123',
        password_confirmation: 'abc123'
      }

      User.create!(user_params)

      session_params = {
        email: 'randomemail@email.com',
        password: 'def456',
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/sessions", params: JSON.generate(session_params), headers: headers

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(data[:errors].first[:status]).to eq('400')
      expect(data[:errors].first[:title]).to eq("Email or password incorrect")
    end

    it "returns a status of 400 and an appropriate, secure error message if an incorrect email is sent" do
      user_params = {
        name: 'random name',
        email: 'randomemail@email.com',
        password: 'abc123',
        password_confirmation: 'abc123'
      }

      User.create!(user_params)

      session_params = {
        email: 'adfasdfadsf@email.com',
        password: 'abc123',
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/sessions", params: JSON.generate(session_params), headers: headers

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(data[:errors].first[:status]).to eq('400')
      expect(data[:errors].first[:title]).to eq("Email or password incorrect")
    end
  end
end
