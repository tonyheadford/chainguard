module Dibble
  class Sequence
    extend Forwardable
    def_delegators :@sequence, :first, :last, :include?

    def initialize()
      @sequence = []
      @steps = {}
    end

    def add(name, options = {})
      add_item(name.to_sym, options)
    end

    def next(name, entity)
      index = @sequence.index(name.to_sym)
      find_next_item(@sequence.drop(index + 1), entity) unless index.nil?
    end

    def prev(name, entity)
      index = @sequence.index(name.to_sym)
      find_next_item(@sequence.take(index).reverse, entity) unless index.nil?
    end

  private
    def find_next_item(ary, entity)
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

    def add_item(name, options)
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
