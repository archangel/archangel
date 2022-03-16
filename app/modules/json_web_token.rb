# frozen_string_literal: true

# JWT helpers
class JsonWebToken
  # Encode a JWT
  #
  # Encode using a secret key and HS256 hash algorithm
  #
  # @example Encode a string
  #   JsonWebToken.encode('hello') #=> 'eyJhbGciOiJIUzI1NiJ9.ImhlbGxvIg.ds6WTDerLOHykE5Q8fEYmxFA0sQlmXY9l7xsDkWBhfY'
  #
  # @example Encode a hash
  #   JsonWebToken.encode({ foo: 'bar' }) #=> 'eyJhbGciOiJIUzI1NiJ9.eyJmb28iOiJiYXIifQ.vRjiJmPe1vB19QNCFUCvzvlAHBLjLdt-UZvNId9hwdk'
  #
  # @param [String,Hash,Object] payload string, hash or object to be encoded
  # @return [String] encoded web token
  def self.encode(payload)
    JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
  end

  # Decode a JWT
  #
  # Decode using a JWT using secret key and HS256 hash algorithm
  #
  # @example Decode a string
  #   JsonWebToken.decode('eyJhbGciOiJIUzI1NiJ9.ImhlbGxvIg.ds6WTDerLOHykE5Q8fEYmxFA0sQlmXY9l7xsDkWBhfY') #=> 'hello'
  #
  # @example Decode a hash
  #   JsonWebToken.encode('eyJhbGciOiJIUzI1NiJ9.eyJmb28iOiJiYXIifQ.vRjiJmPe1vB19QNCFUCvzvlAHBLjLdt-UZvNId9hwdk') #=> {"foo"=>"bar"}
  #
  # @param [String] token JWT to be decoded
  # @return [String,Hash,Object] decoded web token
  def self.decode(token)
    JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256').first
  end
end
