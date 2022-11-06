require 'swagger_helper'

RSpec.describe 'api/v1/trips', type: :request do

  path '/api/v1/trips' do

    get('list trips') do
      produces 'application/json'
      tags 'Trips'

      parameter name: :favorite_only, in: :path, type: :string

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
                               }
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
          duration: { type: :integer },
          image_url: { type: :string }
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
                             }
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
          duration: { type: :integer },
          image_url: { type: :string }
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
                             }
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



    put('remove trip from current users favorites') do
      produces 'application/json'
      tags 'Trips'

      response(200, 'successful') do
        let(:id) { '123' }
        schema type: :object,
               properties: {
                 success: { type: :string }
               }
        run_test!
      end
    end
  end

  path '/api/v1/trips/{id}/add_to_favorite' do
    put('add trip to current users favorites') do
      produces 'application/json'
      tags 'Trips'

      response(200, 'successful') do
        let(:id) { '123' }
        schema type: :object,
               properties: {
                 success: { type: :string }
               }
        run_test!
      end
    end
  end

  path '/api/v1/trips/{id}/remove_from_favorite' do
    put('remove trip from current users favorites') do
      produces 'application/json'
      tags 'Trips'

      response(200, 'successful') do
        let(:id) { '123' }
        schema type: :object,
               properties: {
                 success: { type: :string }
               }
        run_test!
      end
    end
  end


end
