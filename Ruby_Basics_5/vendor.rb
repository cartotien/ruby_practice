module Vendor
  attr_reader :vendor

  def initialize(*args, vendor)
    super(*args)
    @vendor = vendor
  end

  protected

  attr_writer :vendor
end
