# frozen_string_literal: true

class ApplicationService
  attr_reader :result

  def self.call(*args)
    new(*args).call
  end

  def initialize(*_); end

  def call
    @result = nil
    payload
    self
  end

  def success?
    errors.empty?
  end

  def errors
    @errors ||= ActiveModel::Errors.new(self)
  end

  private

  def payload; end
end
