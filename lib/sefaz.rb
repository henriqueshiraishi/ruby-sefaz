# frozen_string_literal: true

require 'savon'

require_relative "sefaz/utils/version"
require_relative "sefaz/utils/connection"
require_relative "sefaz/utils/wsdl"
require_relative "sefaz/nfe"


module SEFAZ

  def self.toXML(hash); Gyoku.xml(hash, key_converter: :none) end
  def self.toHASH(xml); Nori.new(convert_tags_to: lambda { |key| key.to_sym }).parse(xml) end

end
