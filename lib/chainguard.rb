require "chainguard/version"
require "chainguard/sequencer"

module Chainguard
  def self.define
    sequence = Sequencer.new
    yield sequence if block_given?
    sequence
  end
end
