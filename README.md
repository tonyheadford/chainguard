# Dibble

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dibble'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dibble

## Usage

```ruby
    # define your sequence in the correct order

    my_sequence = Dibble.sequence do |s|
        s.add :first_item
        s.add :another_item

        # items can have conditions resolved by calling a method
        # when calling .next on the previous item :an_item_with_a_condition will only be
        # returned if the method my_condition_has_been_met? returns true
        # otherwise it will look at the next item and try to resolve that and so on
        s.add :an_item_with_a_condition, unless: :my_condition_has_been_met?

        # items can have conditions resolved with a lambda
        s.add :an_item_with_a_lambda, if: ->(context) { context.has_some_value? }
    end

    # get the starting point
    step = my_sequence.first

    # ...

    # keep track of state e.g. collection of data from a UI in some data object/class
    # and pass this to .next
    # The context is passed the lambda to resolve the condition
    step = my_sequence.next(step, my_data_context)

```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tonyheadford/dibble.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

