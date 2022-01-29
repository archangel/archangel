# frozen_string_literal: true

RSpec.describe JsonWebToken do
  subject(:jwt) { described_class }

  let(:payload) { { 'sub' => 'archangel' } }
  let(:token) { 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhcmNoYW5nZWwifQ.URvDIGlucjd-ij42mBjL3gV3e1XljpCKKuPb7QeuLRs' }

  describe '.encode' do
    it { expect(jwt.encode(payload)).to eq(token) }
  end

  describe '.decode' do
    it { expect(jwt.decode(token)).to eq(payload) }
  end
end
