require 'swagger_helper'
# rake rswag:specs:swaggerize
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

      response(200, 'successful') do
        schema type: :object,
               properties: {
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

  path '/oauth/token' do

    post('Login or Refresh (get token)') do
      produces 'application/json'
      consumes "application/json"
      tags 'Users'

      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          client_id: { type: :string },
          client_secret: { type: :string },
          grant_type: { type: :string },
          password: { type: :string },
          email: { type: :string },
          refresh_token: {type: :string}
        },
        required: ['client_id', 'client_secret', 'grant_type']
      }

      response(200, 'successful') do
        schema type: :object,
               properties: {
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
