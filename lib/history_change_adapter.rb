# frozen_string_literal: true

class HistoryChangeAdapter
  # Builds the `object_changes` JSONB value based on a hash of changed attributes.
  #
  # @param [Hash] changes Changed attributes
  # @return [Array<Hash>]
  def diff(changes)
    [].tap do |formatted_changes|
      changes.each_pair do |field, value_changes|
        formatted_changes << { field: field, old: value_changes[0], new: value_changes[1] }
      end
    end
  end
end
