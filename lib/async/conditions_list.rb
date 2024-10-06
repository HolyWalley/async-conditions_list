# frozen_string_literal: true

require_relative "conditions_list/version"
require "async"

module Async
  # The ConditionsList class manages a collection of Async::Condition objects,
  # allowing you to wait on multiple conditions and get accumulated result.
  #
  # == Initialization
  #
  # To create a new ConditionsList, specify the number of conditions you want to manage:
  #
  #   conditions_list = Async::ConditionsList.new(size)
  #
  # == Methods
  #
  # - `wait`: Waits on all conditions in the list.
  #
  # - `signal(value = nil)`: Signals the current condition being waited on.
  #   If no condition has been waited on yet, it raises `ConditionsList::Error`.
  #
  # == Example Usage
  #
  #   require 'async'
  #   require 'async/conditions_list'
  #
  #   conditions_list = Async::ConditionsList.new(3)
  #
  #   Sync do |task|
  #     task.async do
  #       conditions_list.wait
  #       puts "All conditions have been met!"
  #     end
  #
  #     # Simulate asynchronous events
  #     task.sleep(1)
  #     conditions_list.signal
  #     task.sleep(1)
  #     conditions_list.signal
  #     task.sleep(1)
  #     conditions_list.signal
  #   end
  #
  # == Error Handling
  #
  # - Raises `ConditionsList::Error` if `signal` is called before any condition has been waited on.
  #
  # == Notes
  #
  # - Ensure that the `wait` method is called before `signal` to avoid errors.
  # - This class is intended to be used within the `Async` scheduler.
  #
  class ConditionsList
    class Error < StandardError; end

    def initialize(size)
      @list = Array.new(size) { Async::Condition.new }
      @current_condition = nil
    end

    def wait
      @list.map do |condition|
        @current_condition = condition
        condition.wait
      end
    end

    def signal(value = nil)
      raise Error, "No condition has been waited on yet." unless @current_condition

      @current_condition.signal(value)
    end
  end
end
