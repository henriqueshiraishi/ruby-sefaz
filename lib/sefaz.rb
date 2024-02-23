# frozen_string_literal: true

require 'json'
require 'net/http'
require 'savon'

require 'sefaz/base'
require 'sefaz/configuration'
require 'sefaz/exception'
require 'sefaz/refinement'
require 'sefaz/version'

require 'sefaz/utils/connection'
require 'sefaz/utils/signer'
require 'sefaz/webservice/base'

require 'sefaz/webservice/nfe/client'
require 'sefaz/webservice/nfe/auditor'
require 'sefaz/webservice/nfe/connection'
require 'sefaz/webservice/nfe/dataset'
require 'sefaz/webservice/nfe/validator'
require 'sefaz/webservice/nfe/wsdl'

module SEFAZ
  # Personalize as configurações padrão da biblioteca usando bloco
  # config/initializers/sefaz_config.rb
  #   SEFAZ.configure do |config|
  #     config.xxxxxxx = "xxxxxxx"
  #   end
  # Se nenhum bloco for fornecido, retorna o objeto de configuração padrão
  def self.configure
    if block_given?
      yield(Configuration.default)
    else
      Configuration.default
    end
  end
end
