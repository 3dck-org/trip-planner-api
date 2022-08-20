require 'swagger_helper'

RSpec.describe 'api/v1/addresses', type: :request do

  path '/api/v1/addresses' do

    get('list addresses') do
      produces 'application/json'
      tags 'Addresses'

      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   street: { type: :string },
                   buildingNumber: { type: :string },
                   apartment: { type: :string },
                   postalCode: { type: :string },
                   created_at: { type: :string, format: :datetime },
                   updated_at: { type: :string, format: :datetime }
                 }
               }
        run_test!
      end
    end

    post('create address') do
      produces 'application/json'
      consumes "application/json"
      tags 'Addresses'
      security [Bearer: {}]

      parameter name: :address, in: :body, schema: {
        type: :object,
        properties: {
          street: { type: :string },
          buildingNumber: { type: :string },
          apartment: { type: :string },
          postalCode: { type: :string },
        },
        required: ['street', 'buildingNumber', 'postalCode']
      }

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 street: { type: :string },
                 buildingNumber: { type: :string },
                 apartment: { type: :string },
                 postalCode: { type: :string },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime }
               }
        run_test!
      end
    end
  end

  path '/api/v1/addresses/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'address id'

    get('show address') do
      produces 'application/json'
      tags 'Addresses'
      security [Bearer: {}]

      response(200, 'successful') do
        let(:id) { '123' }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 street: { type: :string },
                 buildingNumber: { type: :string },
                 apartment: { type: :string },
                 postalCode: { type: :string },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime }
               }
        run_test!
      end
    end

    put('update address') do
      produces 'application/json'
      consumes "application/json"
      tags 'Addresses'
      security [Bearer: {}]

      parameter name: :address, in: :body, schema: {
        type: :object,
        properties: {
          street: { type: :string },
          buildingNumber: { type: :string },
          apartment: { type: :string },
          postalCode: { type: :string },
        }
      }

      response(200, 'successful') do
        let(:id) { '123' }
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 street: { type: :string },
                 buildingNumber: { type: :string },
                 apartment: { type: :string },
                 postalCode: { type: :string },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime }
               }
        run_test!
      end
    end

    delete('delete address') do
      produces 'application/json'
      tags 'Addresses'
      security [Bearer: {}]

      response(200, 'successful') do
        let(:id) { '123' }

        run_test!
      end
    end
  end
end
