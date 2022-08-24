require 'swagger_helper'

RSpec.describe 'api/v1/trip_place_infos', type: :request do

  path '/api/v1/trip_place_infos' do

    get('list trip_place_infos') do
      produces 'application/json'
      tags 'TripPlaceInfos'

      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   place_id: { type: :integer },
                   trip_id: { type: :integer },
                   comment: { type: :string },
                   order: { type: :integer },
                   created_at: { type: :string, format: :datetime },
                   updated_at: { type: :string, format: :datetime }
                 }
               }
        run_test!
      end
    end

    post('create trip_place_info') do
      consumes 'application/json'
      produces 'application/json'
      tags 'TripPlaceInfos'

      parameter name: :trip_place_info, in: :body, schema: {
        type: :object,
        properties: {
          place_id: { type: :integer },
          trip_id: { type: :integer },
          comment: { type: :string },
          order: { type: :integer }
        },
        required: ['place_id', 'trip_id']
      }

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 place_id: { type: :integer },
                 trip_id: { type: :integer },
                 comment: { type: :string },
                 order: { type: :integer },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime }
               }
        run_test!
      end
    end
  end

  path '/api/v1/trip_place_infos/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show trip_place_info') do
      produces 'application/json'
      tags 'TripPlaceInfos'

      response(200, 'successful') do
        let(:id) { '123' }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 place_id: { type: :integer },
                 trip_id: { type: :integer },
                 comment: { type: :string },
                 order: { type: :integer },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime }
               }
        run_test!
      end
    end

    put('update trip_place_info') do
      consumes 'application/json'
      produces 'application/json'
      tags 'TripPlaceInfos'

      parameter name: :trip_place_info, in: :body, schema: {
        type: :object,
        properties: {
          place_id: { type: :integer },
          trip_id: { type: :integer },
          comment: { type: :string },
          order: { type: :integer }
        },
        required: ['place_id', 'trip_id']
      }

      response(200, 'successful') do
        let(:id) { '123' }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 place_id: { type: :integer },
                 trip_id: { type: :integer },
                 comment: { type: :string },
                 order: { type: :integer },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime }
               }
        run_test!
      end
    end

    delete('delete trip_place_info') do
      produces 'application/json'
      tags 'TripPlaceInfos'

      response(200, 'successful') do
        let(:id) { '123' }
        run_test!
      end
    end
  end
end

