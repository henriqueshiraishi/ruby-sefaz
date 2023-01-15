# frozen_string_literal: true

require 'json'
require 'net/http'
require 'net/http/post/multipart'
require 'savon'

require_relative "sefaz/utils/version"
require_relative "sefaz/utils/connection"
require_relative "sefaz/utils/wsdl"
require_relative "sefaz/utils/assinador"
require_relative "sefaz/utils/validador"
require_relative "sefaz/utils/auditor"
require_relative "sefaz/utils/danfe"
require_relative "sefaz/nfe"


module SEFAZ

  def self.to_xml(hash); Gyoku.xml(hash, key_converter: :none) end
  def self.to_hash(xml); Nori.new(convert_tags_to: lambda { |key| key.to_sym }).parse(xml) end
  def self.remove_blank(documento)
    xml = (documento.is_a?(Hash) ? SEFAZ.to_xml(documento) : documento)
    doc = Nokogiri::XML::Document.parse(xml, nil, "utf-8", Nokogiri::XML::ParseOptions::NOBLANKS)
    doc.search('*').each { |node| node.remove if node.content.strip.blank? }
    xml = doc.canonicalize
    return [xml, SEFAZ.to_hash(xml)]
  end

end
