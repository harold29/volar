require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'POST /users/login' do
    let(:login_url) { '/users/login' }
    let(:user) { create :user, email: FFaker::Internet.email, password: '12345678'}

    describe 'correct login info' do
      let(:login_payload) do
        {
          user: {
            email: user.email,
            password: '12345678'
          }
        }
      end

      it 'get_success code' do
        post login_url, params: login_payload

        expect(response).to have_http_status(:success)
      end

      it 'get user data' do
        post login_url, params: login_payload

        json_body = JSON.parse(body)

        expect(json_body['data']['email']).to eq(user.email)
        expect(json_body['data']['id']).to eq(user.id)
        expect(json_body['data']['created_at']).not_to eq(nil)
      end

      it 'get authorization token' do
        post login_url, params: login_payload

        expect(headers['Content-Type']).to include('application/json;')
        expect(headers['Authorization']).to include('Bearer')
      end
    end

    describe 'incorrect login info' do
      let(:login_payload) do
        {
          user: {
            email: user.email,
            password: '123456789'
          }
        }
      end

      it 'get unprocessable 422 code' do
        post login_url, params: login_payload
        expect(response).to be_unprocessable
      end

      it 'do not get user data' do
        post login_url, params: login_payload

        json_body = JSON.parse(body)

        expect(json_body['data']).to eq(nil)
        expect(json_body['messages'][0]).to eq("Invalid Email or Password.")
      end

      it 'do not get authorization token' do
        post login_url, params: login_payload

        expect(headers['Content-Type']).to include('application/json;')
        expect(headers['Authorization']).to eq(nil)
      end
    end
  end

  describe 'DELETE /users/logout' do
    let(:login_url) { '/users/login' }
    let(:logout_url) { '/users/logout' }
    let(:user) { create :user, email: 'test@test.com', password: '12345678'}

    context 'already logged in user' do
      let(:login_payload) do
        {
          user: {
            email: user.email,
            password: '12345678'
          }
        }
      end

      before do
        post login_url, params: login_payload
      end

      it 'get success code and log out message ' do
        token = headers['Authorization']

        delete logout_url, headers: { 'Authorization': token }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(body)['message']).to eq('Logged out successfully')
      end
    end

    context 'user not logged in' do
      context 'session not found' do
        it 'get unauthorized code and log out message ' do
          token = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiMTU2Y2I4Ny1lZDFjLTRkZDktODljOS02MjI5MDhkNTYyMzYiLCJzY3AiOiJ1c2VyIiwiYXVkIjpudWxsLCJpYXQiOjE3MTE4NTgwNzIsImV4cCI6MTcxMTk0NDQ3MiwianRpIjoiZDg0YmExYWMtYzE1Ni00NTk1LWJjM2UtNzQ2MzQ5OTAzOWZjIn0.4eKyJQRk93pUlXKRamCLEEt4pSk3XsRUSfwZfKkP1Hk'

          delete logout_url, headers: { 'Authorization': token }

          expect(response).to have_http_status(:unauthorized)
          expect(JSON.parse(body)['message']).to eq("Couldn't find an active session.")
        end

        context 'token not sent in request' do
          it 'get unauthorized code and log out message' do
            delete logout_url

            expect(response).to have_http_status(:unauthorized)
            expect(JSON.parse(body)['message']).to eq("Couldn't find an active session.")
          end
        end
      end
    end
  end
end
