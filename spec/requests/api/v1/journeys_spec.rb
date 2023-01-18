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
                   updated_at: { type: :string, format: :datetime },
                   journey_place_infos: {
                     type: :array,
                     items: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         journey_id: { type: :integer },
                         place_id: { type: :integer },
                         status: { type: :string },
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
                 updated_at: { type: :string, format: :datetime },
                 journey_place_infos: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       journey_id: { type: :integer },
                       place_id: { type: :integer },
                       status: { type: :string },
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
                 updated_at: { type: :string, format: :datetime },
                 journey_place_infos: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       journey_id: { type: :integer },
                       place_id: { type: :integer },
                       status: { type: :string },
                       created_at: { type: :string, format: :datetime },
                       updated_at: { type: :string, format: :datetime }
                     }
                   }
                 }
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
                 updated_at: { type: :string, format: :datetime },
                 journey_place_infos: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       journey_id: { type: :integer },
                       place_id: { type: :integer },
                       status: { type: :string },
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

  path '/api/v1/current_journey' do

    get('current journey of the user') do
      produces 'application/json'
      tags 'Journeys'

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
                 updated_at: { type: :string, format: :datetime },
                 trip: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     user_id: { type: :string },
                     name: { type: :string },
                     description: { type: :string },
                     distance: { type: :string, format: :float },
                     duration: { type: :integer },
                     image_url: { type: :string },
                     favorite: { type: :string },
                     created_at: { type: :string, format: :datetime },
                     updated_at: { type: :string, format: :datetime },
                     trip_place_infos: {
                       type: :array,
                       items: {
                         type: :object,
                         properties: {
                           place_id: { type: :integer },
                           trip_id: { type: :integer },
                           comment: { type: :string },
                           order: { type: :integer },
                           place: {
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
                               address: {
                                 type: :object,
                                 properties: {
                                   id: { type: :integer },
                                   street: { type: :string },
                                   buildingNumber: { type: :string },
                                   apartment: { type: :string },
                                   postalCode: { type: :string },
                                   created_at: { type: :string, format: :datetime },
                                   updated_at: { type: :string, format: :datetime }
                                 },
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
                           }
                         }
                       }
                     }
                   }
                 },
                 user: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     name: { type: :string },
                     surname: { type: :string },
                     birthday: { type: :string, format: :date },
                     login: { type: :string },
                     email: { type: :string },
                     created_at: { type: :string, format: :datetime },
                     updated_at: { type: :string, format: :datetime },
                     role_id: { type: :integer },
                     image_url: { type: :string }
                   }
                 },
                 journey_place_infos: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       journey_id: { type: :integer },
                       place_id: { type: :integer },
                       status: { type: :string },
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

  path '/api/v1/update_place_status' do
    put('update status of a place in the journey') do
      produces 'application/json'
      consumes "application/json"
      tags 'Journeys'

      parameter name: :journey_place_info, in: :body, schema: {
        type: :object,
        properties: {
          journey_id: { type: :integer },
          place_id: { type: :integer },
          status: { type: :string }
        }
      }

      response(200, 'successful') do
        let(:id) { '123' }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 journey_id: { type: :integer },
                 place_id: { type: :integer },
                 status: { type: :string },
                 created_at: { type: :string, format: :datetime },
                 updated_at: { type: :string, format: :datetime }
               }
        run_test!
      end
    end
  end
end
