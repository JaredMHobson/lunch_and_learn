require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_uniqueness_of :api_key }
    it { should validate_presence_of(:password)}
    it { should have_secure_password}
    it { should allow_value('something@something.something').for(:email) }
    it { should_not allow_value('something somthing@something.something').for(:email) }
    it { should_not allow_value('something.something@').for(:email) }
    it { should_not allow_value('something').for(:email) }
  end

  describe 'associations' do
    it { should have_many :favorites }
  end

  it 'exists and has attributes' do
    user_data = {
      name: 'random name',
      email: 'randomemail@email.com',
      password: 'abc123'
    }

    user = User.create!(user_data)

    expect(user).to be_a User
    expect(user.name).to eq('random name')
    expect(user.email).to eq('randomemail@email.com')
    expect(user.password).to eq('abc123')
    expect(user.api_key).to be_a String
  end

  describe '#generate_api_key' do
    it 'generates an api key so that it can be saved when creating the model' do
      user_data = {
        name: 'random name',
        email: 'randomemail@email.com',
        password: 'abc123'
      }

      user = User.new(user_data)

      expect(user.api_key).to be nil

      user.generate_api_key

      expect(user.api_key).to be_a String
    end
  end
end
