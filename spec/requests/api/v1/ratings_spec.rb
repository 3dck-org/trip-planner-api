require 'swagger_helper'

RSpec.describe 'api/v1/ratings', type: :request do

  path '/api/v1/ratings' do

    post('create rating') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Ratings'

      parameter name: :rating, in: :body, schema: {
        type: :object,
        properties: {
          trip_id: { type: :integer },
          grade: { type: :integer }
        },
        required: ['trip_id', 'grade']
      }

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 trip_id: { type: :integer },
                 user_id: { type: :integer },
                 grade: { type: :integer },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime },
               }


        run_test!
      end
    end
  end
end
