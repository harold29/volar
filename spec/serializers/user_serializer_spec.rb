require 'rails_helper'

RSpec.describe UserSerializer do
  describe 'serialize' do
    let(:user) { create :user }
    let(:serialized_fields) { UserSerializer.new(user).serializable_hash }

    it 'get serialized fields' do
      expect(serialized_fields[:id]).to eq(user.id)
      expect(serialized_fields[:email]).to eq(user.email)
      expect(serialized_fields[:created_at]).to eq(user.created_at)
    end
  end
end
