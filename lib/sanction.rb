require "active_support/core_ext"
require "active_support"

require 'sanction/searchable_array'
require "sanction/version"
require 'sanction/tree'
require 'sanction/node'
require 'sanction/blacklist'
require 'sanction/whitelist'
require 'sanction/permission'

module Sanction

  extend self

  def build(hash)
    "sanction/#{hash[:mode]}".classify.constantize.new(hash)
  end

end
