require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do

  path '/api/v1/users' do

    post('create user') do
      produces 'application/json'
      consumes "application/json"
      tags 'Users'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          client_id: { type: :string },
          password: { type: :string },
          name: { type: :string },
          email: { type: :string },
          surname: { type: :string },
          login: { type: :string }
        },
        required: ['client_id', 'password', 'name', 'email', 'surname', 'login']
      }

      # parameter name: :client_id, in: :body, required: true, description: 'Application client id', schema: { type: :string }
      # parameter name: :password, in: :body, required: true, description: 'User Password', schema: { type: :string }
      # parameter name: :name, in: :body, required: true, description: 'User Name', schema: { type: :string }
      # parameter name: :email, in: :body, required: true, description: 'User Email', schema: { type: :string }
      # parameter name: :surname, in: :body, required: true, description: 'User Surname', schema: { type: :string }
      # parameter name: :login, in: :body, required: true, description: 'User Login', schema: { type: :string }

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 email: { type: :string },
                 access_token: { type: :string },
                 token_type: { type: :string },
                 expires_in: { type: :integer },
                 refresh_token: { type: :string },
                 created_at: { type: :integer }
               }
        run_test!
      end
    end
  end
end
