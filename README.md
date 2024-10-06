# Async::ConditionsList

An extension to Async gem that allows to create a list of condition, wait for it and receive an array of results

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG

## Usage

```ruby
require 'async'
require 'async/conditions_list'

conditions_list = Async::ConditionsList.new(3)

Sync do |task|
  task.async do
    results = conditions_list.wait
    p "All conditions have been met!"
    p results
  end

  # Simulate asynchronous events
  task.sleep(1)
  conditions_list.signal(1)
  task.sleep(1)
  conditions_list.signal(2)
  task.sleep(1)
  conditions_list.signal(3)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/holywalley/async-conditions_list.
