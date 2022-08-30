# frozen_string_literal: true

module Vendor
  attr_reader :vendor

  VENDOR_NAME_FORMAT = /[a-z]{7,20}/i.freeze

  def initialize(*args, vendor)
    super(*args)
    @vendor = vendor
    validate!
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  protected

  attr_writer :vendor

  def validate!
    super
    raise 'Wrong vendor name format' if vendor !~ VENDOR_NAME_FORMAT
  end
end
