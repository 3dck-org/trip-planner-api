require 'swagger_helper'

RSpec.describe 'api/v1/places', type: :request do

  path '/api/v1/places' do

    get('list places') do
      produces 'application/json'
      tags 'Places'

      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   description: { type: :string },
                   address_id: { type: :integer },
                   point: {
                     type: :object,
                     properties: {
                       x: { type: :string },
                       y: { type: :string }
                     }
                   },
                   created_at: { type: :string, format: :datetime },
                   updated_at: { type: :string, format: :datetime },
                   category_dictionaries: {
                     type: :array,
                     items: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         name: { type: :string },
                         created_at: { type: :string, format: :datetime },
                         updated_at: { type: :string, format: :datetime }
                       }
                     }
                   }
                 }
               }
        run_test!
      end

    end

    post('create place') do
      produces 'application/json'
      consumes 'application/json'
      tags 'Places'

      parameter name: :place, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          address_id: { type: :integer },
          point: { type: :string },
          category_names: {
            type: :array,
            items: {
              type: :string
            }
          }
        },
        required: ['name', 'description', 'address_id', 'point']
      }

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :string },
                 address_id: { type: :integer },
                 point: {
                   type: :object,
                   properties: {
                     x: { type: :string },
                     y: { type: :string }
                   }
                 },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime },
                 category_dictionaries: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       created_at: { type: :string, format: :datetime },
                       updated_at: { type: :string, format: :datetime }
                     }
                   }
                 }
               }
        run_test!
      end
    end
  end

  path '/api/v1/places/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show place') do
      produces 'application/json'
      tags 'Places'

      response(200, 'successful') do
        let(:id) { '123' }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :string },
                 address_id: { type: :integer },
                 point: {
                   type: :object,
                   properties: {
                     x: { type: :string },
                     y: { type: :string }
                   }
                 },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime },
                 category_dictionaries: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       created_at: { type: :string, format: :datetime },
                       updated_at: { type: :string, format: :datetime }
                     }
                   }
                 }
               }
        run_test!
      end
    end

    put('update place') do
      produces 'application/json'
      consumes 'application/json'
      tags 'Places'

      parameter name: :place, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          address_id: { type: :integer },
          point: { type: :string },
          category_names: {
            type: :array,
            items: {
              type: :string
            }
          }
        },
        required: ['name', 'description', 'address_id', 'point']
      }

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :string },
                 address_id: { type: :integer },
                 point: {
                   type: :object,
                   properties: {
                     x: { type: :string },
                     y: { type: :string }
                   }
                 },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime },
                 category_dictionaries: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       created_at: { type: :string, format: :datetime },
                       updated_at: { type: :string, format: :datetime }
                     }
                   }
                 }
               }
        run_test!
      end
    end

    delete('delete place') do
      produces 'application/json'
      tags 'Places'

      response(200, 'successful') do
        let(:id) { '123' }

        run_test!
      end
    end
  end
end
