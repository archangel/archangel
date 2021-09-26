# frozen_string_literal: true

require 'rails_helper'

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
        title: 'Archangel API V1',
        description: 'Headless CMS',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'Development'
        }
      ],
      components: {
        securitySchemes: {
          Bearer: {
            type: :apiKey,
            name: 'Authorization',
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
          auth_create_item: {
            type: :object,
            required: %w[token],
            properties: {
              token: { type: :string }
            }
          },
          auth_create: {
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
                '$ref' => '#/components/schemas/auth_create_item'
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
