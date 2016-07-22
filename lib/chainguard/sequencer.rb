module Chainguard
  class Sequencer
    extend Forwardable
    def_delegators :@sequence, :first, :last, :include?

    def initialize()
      @sequence = []
      @steps = {}
    end

    def step(name, options = {})
      add_step(name.to_sym, options)
    end

    def first_step
      @sequence.first
    end

    def last_step
      @sequence.last
    end

    def next_step(name, entity)
      index = @sequence.index(name.to_sym)
      find_next_step(@sequence.drop(index + 1), entity) unless index.nil?
    end

    def prev_step(name, entity)
      index = @sequence.index(name.to_sym)
      find_next_step(@sequence.take(index).reverse, entity) unless index.nil?
    end

  private
    def find_next_step(ary, entity)
      item = nil
      ary.each do |name|
        options = @steps.fetch(name, {})
        if options.has_key? :if
          condition = options.fetch(:if)
          item = name if handle_condition(entity, condition)
        elsif options.has_key? :unless
          condition = options.fetch(:unless)
          item = name unless handle_condition(entity, condition)
        else
          item = name
        end
        break unless item.nil?
      end
      item
    end

    def add_step(name, options)
      @sequence << name unless @sequence.include? name
      @steps[name] = options
    end

    def handle_condition(obj, condition)
      if condition.is_a? Symbol
        obj.send(condition)
      elsif condition.respond_to? :call
        condition.call(obj)
      else 
        false
      end
    end
  end
end
