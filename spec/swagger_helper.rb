# frozen_string_literal: true

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Archangel API',
        description: 'Headless CMS',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'Local Development'
        },
        {
          url: 'https://archangel.local',
          description: 'archangel.local'
        }
      ],
      components: {
        securitySchemes: {
          Bearer: {
            type: :apiKey,
            name: 'Authorization',
            in: :header
          },
          Subdomain: {
            type: :apiKey,
            name: 'X-Archangel-Site',
            in: :header
          }
        },
        schemas: {
          not_found: {
            type: :object,
            required: %w[success status message],
            properties: {
              success: {
                type: :boolean,
                default: false
              },
              status: {
                type: :integer,
                default: 404
              },
              message: { type: :string }
            }
          },
          unauthorized: {
            type: :object,
            required: %w[success status message],
            properties: {
              success: {
                type: :boolean,
                default: false
              },
              status: {
                type: :integer,
                default: 401
              },
              message: { type: :string }
            }
          },
          unprocessable: {
            type: :object,
            required: %w[success status errors],
            properties: {
              success: {
                type: :boolean,
                default: false
              },
              status: {
                type: :integer,
                default: 422
              },
              errors: { type: :object }
            }
          },
          session_item: {
            type: :object,
            required: %w[token exp],
            properties: {
              token: { type: :string },
              exp: { type: :string }
            }
          },
          session: {
            type: :object,
            required: %w[success status data],
            properties: {
              success: {
                type: :boolean,
                default: true
              },
              status: {
                type: :integer,
                default: 202
              },
              data: {
                '$ref' => '#/components/schemas/session_item'
              }
            }
          },
          collection_entry_item: {
            type: :object,
            required: %w[content],
            properties: {
              id: { type: :integer },
              content: { type: :object },
              position: { type: :integer },
              publishedAt: {
                type: :string,
                nullable: true
              },
              deletedAt: {
                type: :string,
                nullable: true,
                default: nil
              }
            }
          },
          collection_entry: {
            type: :object,
            required: %w[success status data],
            properties: {
              success: {
                type: :boolean,
                default: true
              },
              status: {
                type: :integer,
                default: 200
              },
              data: {
                '$ref' => '#/components/schemas/collection_entry_item'
              }
            }
          },
          collection_entries: {
            type: :object,
            required: %w[success status data],
            properties: {
              success: {
                type: :boolean,
                default: true
              },
              status: {
                type: :integer,
                default: 200
              },
              data: {
                type: :array,
                items: { '$ref' => '#/components/schemas/collection_entry_item' }
              }
            }
          },
          collection_field_item: {
            type: :object,
            required: %w[label key classification required position],
            properties: {
              label: { type: :string },
              key: { type: :string },
              classification: { type: :string },
              required: { type: :boolean },
              position: { type: :integer }
            }
          },
          collection_item: {
            type: :object,
            required: %w[name slug],
            properties: {
              name: { type: :string },
              slug: { type: :string },
              publishedAt: {
                type: :string,
                nullable: true
              },
              deletedAt: {
                type: :string,
                nullable: true,
                default: nil
              },
              fields: {
                type: :array,
                items: { '$ref' => '#/components/schemas/collection_field_item' }
              },
              entries: {
                type: :array,
                items: { '$ref' => '#/components/schemas/collection_entry_item' }
              }
            }
          },
          collection: {
            type: :object,
            required: %w[success status data],
            properties: {
              success: {
                type: :boolean,
                default: true
              },
              status: {
                type: :integer,
                default: 200
              },
              data: {
                '$ref' => '#/components/schemas/collection_item'
              }
            }
          },
          collections: {
            type: :object,
            required: %w[success status data],
            properties: {
              success: {
                type: :boolean,
                default: true
              },
              status: {
                type: :integer,
                default: 200
              },
              data: {
                type: :array,
                items: { '$ref' => '#/components/schemas/collection_item' }
              }
            }
          },
          content_item: {
            type: :object,
            required: %w[name slug body],
            properties: {
              name: { type: :string },
              slug: { type: :string },
              body: { type: :string },
              publishedAt: {
                type: :string,
                nullable: true
              },
              deletedAt: {
                type: :string,
                nullable: true,
                default: nil
              },
              stores: {
                type: :array,
                items: { '$ref' => '#/components/schemas/store_item' }
              }
            }
          },
          content: {
            type: :object,
            required: %w[success status data],
            properties: {
              success: {
                type: :boolean,
                default: true
              },
              status: {
                type: :integer,
                default: 200
              },
              data: {
                '$ref' => '#/components/schemas/content_item'
              }
            }
          },
          contents: {
            type: :object,
            required: %w[success status data],
            properties: {
              success: {
                type: :boolean,
                default: true
              },
              status: {
                type: :integer,
                default: 200
              },
              data: {
                type: :array,
                items: { '$ref' => '#/components/schemas/content_item' }
              }
            }
          },
          profile_item: {
            type: :object,
            required: %w[email username firstName lastName name locked],
            properties: {
              email: { type: :string },
              username: { type: :string },
              firstName: { type: :string },
              lastName: { type: :string },
              name: { type: :string },
              locked: {
                type: :boolean,
                default: false
              },
              deletedAt: {
                type: :string,
                nullable: true,
                default: nil
              }
            }
          },
          profile: {
            type: :object,
            required: %w[success status data],
            properties: {
              success: {
                type: :boolean,
                default: true
              },
              status: {
                type: :integer,
                default: 200
              },
              data: {
                '$ref' => '#/components/schemas/profile_item'
              }
            }
          },
          profile_permission_item: {
            type: :object,
            required: %w[collection collectionEntry content profile site user],
            properties: {
              collection: {
                '$ref' => '#/components/schemas/profile_permission_item_collection'
              },
              collectionEntry: {
                '$ref' => '#/components/schemas/profile_permission_item_collection_entry'
              },
              content: {
                '$ref' => '#/components/schemas/profile_permission_item_content'
              },
              profile: {
                '$ref' => '#/components/schemas/profile_permission_item_profile'
              },
              site: {
                '$ref' => '#/components/schemas/profile_permission_item_site'
              },
              user: {
                '$ref' => '#/components/schemas/profile_permission_item_user'
              }
            }
          },
          profile_permission_item_collection: {
            type: :object,
            required: %w[index show new create edit update destroy restore],
            properties: {
              index: {
                type: :boolean,
                default: false
              },
              show: {
                type: :boolean,
                default: false
              },
              new: {
                type: :boolean,
                default: false
              },
              create: {
                type: :boolean,
                default: false
              },
              edit: {
                type: :boolean,
                default: false
              },
              update: {
                type: :boolean,
                default: false
              },
              destroy: {
                type: :boolean,
                default: false
              },
              restore: {
                type: :boolean,
                default: false
              }
            }
          },
          profile_permission_item_collection_entry: {
            type: :object,
            required: %w[index show new create edit update destroy restore reposition],
            properties: {
              index: {
                type: :boolean,
                default: false
              },
              show: {
                type: :boolean,
                default: false
              },
              new: {
                type: :boolean,
                default: false
              },
              create: {
                type: :boolean,
                default: false
              },
              edit: {
                type: :boolean,
                default: false
              },
              update: {
                type: :boolean,
                default: false
              },
              destroy: {
                type: :boolean,
                default: false
              },
              restore: {
                type: :boolean,
                default: false
              },
              reposition: {
                type: :boolean,
                default: false
              }
            }
          },
          profile_permission_item_content: {
            type: :object,
            required: %w[index show new create edit update destroy restore],
            properties: {
              index: {
                type: :boolean,
                default: false
              },
              show: {
                type: :boolean,
                default: false
              },
              new: {
                type: :boolean,
                default: false
              },
              create: {
                type: :boolean,
                default: false
              },
              edit: {
                type: :boolean,
                default: false
              },
              update: {
                type: :boolean,
                default: false
              },
              destroy: {
                type: :boolean,
                default: false
              },
              restore: {
                type: :boolean,
                default: false
              }
            }
          },
          profile_permission_item_profile: {
            type: :object,
            required: %w[show edit update],
            properties: {
              show: {
                type: :boolean,
                default: false
              },
              edit: {
                type: :boolean,
                default: false
              },
              update: {
                type: :boolean,
                default: false
              }
            }
          },
          profile_permission_item_site: {
            type: :object,
            required: %w[show edit update],
            properties: {
              show: {
                type: :boolean,
                default: false
              },
              edit: {
                type: :boolean,
                default: false
              },
              update: {
                type: :boolean,
                default: false
              }
            }
          },
          profile_permission_item_user: {
            type: :object,
            required: %w[index show new create edit update destroy reinvite retoken unlock],
            properties: {
              index: {
                type: :boolean,
                default: false
              },
              show: {
                type: :boolean,
                default: false
              },
              new: {
                type: :boolean,
                default: false
              },
              create: {
                type: :boolean,
                default: false
              },
              edit: {
                type: :boolean,
                default: false
              },
              update: {
                type: :boolean,
                default: false
              },
              destroy: {
                type: :boolean,
                default: false
              },
              reinvite: {
                type: :boolean,
                default: false
              },
              retoken: {
                type: :boolean,
                default: false
              },
              unlock: {
                type: :boolean,
                default: false
              }
            }
          },
          profile_permission: {
            type: :object,
            required: %w[success status data],
            properties: {
              success: {
                type: :boolean,
                default: true
              },
              status: {
                type: :integer,
                default: 200
              },
              data: {
                '$ref' => '#/components/schemas/profile_permission_item'
              }
            }
          },
          site_item: {
            type: :object,
            required: %w[name subdomain],
            properties: {
              name: { type: :string },
              subdomain: { type: :string },
              body: { type: :string },
              formatDate: { type: :string },
              formatDatetime: { type: :string },
              formatTime: { type: :string },
              formatJsDate: { type: :string },
              formatJsDatetime: { type: :string },
              formatJsTime: { type: :string },
              stores: {
                type: :array,
                items: { '$ref' => '#/components/schemas/store_item' }
              }
            }
          },
          site: {
            type: :object,
            required: %w[success status data],
            properties: {
              success: {
                type: :boolean,
                default: true
              },
              status: {
                type: :integer,
                default: 200
              },
              data: {
                '$ref' => '#/components/schemas/site_item'
              }
            }
          },
          store_item: {
            type: :object,
            required: %w[key value],
            properties: {
              key: { type: :string },
              value: {
                type: :string,
                nullable: true
              }
            }
          },
          user_item: {
            type: :object,
            required: %w[email username firstName lastName name locked],
            properties: {
              email: { type: :string },
              username: { type: :string },
              firstName: { type: :string },
              lastName: { type: :string },
              name: { type: :string },
              locked: {
                type: :boolean,
                default: false
              },
              deletedAt: {
                type: :string,
                nullable: true,
                default: nil
              }
            }
          },
          user: {
            type: :object,
            required: %w[success status data],
            properties: {
              success: {
                type: :boolean,
                default: true
              },
              status: {
                type: :integer,
                default: 200
              },
              data: {
                '$ref' => '#/components/schemas/user_item'
              }
            }
          },
          users: {
            type: :object,
            required: %w[success status data],
            properties: {
              success: {
                type: :boolean,
                default: true
              },
              status: {
                type: :integer,
                default: 200
              },
              data: {
                type: :array,
                items: { '$ref' => '#/components/schemas/user_item' }
              }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
