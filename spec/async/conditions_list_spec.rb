# frozen_string_literal: true

require "async"
require "async/conditions_list"
require "async/rspec"

RSpec.describe Async::ConditionsList do
  include_context Async::RSpec::Reactor

  let(:size) { 3 }
  let(:conditions_list) { Async::ConditionsList.new(size) }

  it "waits on all conditions in the list and returns composed result" do
    reactor.async do |task|
      wait_task = task.async { conditions_list.wait }

      size.times { |i| conditions_list.signal(i) }

      result = wait_task.wait

      expect(result).to eq([0, 1, 2])
    end
  end

  describe "#signal" do
    context "when no condition has been waited on" do
      it "raises an Error" do
        expect do
          conditions_list.signal
        end.to raise_error(Async::ConditionsList::Error, "No condition has been waited on yet.")
      end
    end
  end
end
