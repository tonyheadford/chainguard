require "dibble/version"
require "dibble/sequence"

module Dibble
  def self.sequence
    s = Sequence.new
    yield s if block_given?
    s
  end
end
