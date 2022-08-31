# frozen_string_literal: true

module Vendor
  attr_reader :vendor

  def initialize(*args, vendor)
    super(*args)
    @vendor = vendor
    validate!
  end

  protected

  attr_writer :vendor
end
