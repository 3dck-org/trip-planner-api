require 'swagger_helper'

RSpec.describe 'api/v1/trips', type: :request do

  path '/api/v1/trips' do

    get('list trips') do
      produces 'application/json'
      tags 'Trips'

      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   user_id: { type: :string },
                   name: { type: :string },
                   description: { type: :string },
                   distance: { type: :string, format: :float },
                   duration: { type: :integer },
                   created_at: { type: :string, format: :datetime },
                   updated_at: { type: :string, format: :datetime }
                 }
               }
        run_test!
      end
    end

    post('create trip') do
      produces 'application/json'
      consumes "application/json"
      tags 'Trips'

      parameter name: :trip, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :string },
          name: { type: :string },
          description: { type: :string },
          distance: { type: :string, format: :float },
          duration: { type: :integer }
        },
        required: ['name', 'description', 'distance', 'duration', 'user_id']
      }

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :string },
                 name: { type: :string },
                 description: { type: :string },
                 distance: { type: :string, format: :float },
                 duration: { type: :integer },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime }
               }
        run_test!
      end
    end
  end

  path '/api/v1/trips/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'trip id'

    get('show trip') do
      produces 'application/json'
      tags 'Trips'

      response(200, 'successful') do
        let(:id) { '123' }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :string },
                 name: { type: :string },
                 description: { type: :string },
                 distance: { type: :string, format: :float },
                 duration: { type: :integer },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime }
               }
        run_test!
      end
    end

    put('update trip') do
      produces 'application/json'
      consumes "application/json"
      tags 'Trips'

      parameter name: :trip, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :string },
          name: { type: :string },
          description: { type: :string },
          distance: { type: :string, format: :float },
          duration: { type: :integer }
        }
      }

      response(200, 'successful') do
        let(:id) { '123' }
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :string },
                 name: { type: :string },
                 description: { type: :string },
                 distance: { type: :string, format: :float },
                 duration: { type: :integer },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime }
               }
        run_test!
      end
    end

    delete('delete trip') do
      produces 'application/json'
      tags 'Trips'

      response(200, 'successful') do
        let(:id) { '123' }

        run_test!
      end
    end
  end
end
