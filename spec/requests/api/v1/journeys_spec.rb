require 'swagger_helper'

RSpec.describe 'api/v1/journeys', type: :request do

  path '/api/v1/journeys' do

    get('list journeys') do
      produces 'application/json'
      tags 'Journeys'

      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   trip_id: { type: :integer },
                   user_id: { type: :integer },
                   completed: { type: :string },
                   distance: { type: :string, format: :float },
                   start_at: { type: :string, format: :datetime },
                   end_at: { type: :string, format: :datetime },
                   created_at: { type: :string, format: :datetime },
                   updated_at: { type: :string, format: :datetime }
                 }
               }
        run_test!
      end
    end

    post('create journey') do
      produces 'application/json'
      consumes "application/json"
      tags 'Journeys'

      parameter name: :journey, in: :body, schema: {
        type: :object,
        properties: {
          trip_id: { type: :integer },
          start_at: { type: :string, format: :datetime }
        },
        required: ['trip_id']
      }

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 trip_id: { type: :integer },
                 user_id: { type: :integer },
                 completed: { type: :string },
                 distance: { type: :string, format: :float },
                 start_at: { type: :string, format: :datetime },
                 end_at: { type: :string, format: :datetime },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime }
               }
        run_test!
      end
    end
  end

  path '/api/v1/journeys/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show journey') do
      produces 'application/json'
      tags 'Journeys'

      response(200, 'successful') do
        let(:id) { '123' }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 trip_id: { type: :integer },
                 user_id: { type: :integer },
                 completed: { type: :string },
                 distance: { type: :string, format: :float },
                 start_at: { type: :string, format: :datetime },
                 end_at: { type: :string, format: :datetime },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime }
               }
        run_test!
      end
    end

    put('update journey') do
      produces 'application/json'
      consumes "application/json"
      tags 'Journeys'

      parameter name: :journey, in: :body, schema: {
        type: :object,
        properties: {
          completed: { type: :string },
          distance: { type: :string, format: :float },
          start_at: { type: :string, format: :datetime },
          end_at: { type: :string, format: :datetime }
        }
      }

      response(200, 'successful') do
        let(:id) { '123' }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 trip_id: { type: :integer },
                 user_id: { type: :integer },
                 completed: { type: :string },
                 distance: { type: :string, format: :float },
                 start_at: { type: :string, format: :datetime },
                 end_at: { type: :string, format: :datetime },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime }
               }
        run_test!
      end
    end
  end
end
