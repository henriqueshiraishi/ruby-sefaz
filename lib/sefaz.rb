# frozen_string_literal: true

require 'json'
require 'net/http'
require 'savon'
require 'prawn'
require 'prawn/measurement_extensions'
require 'barby'
require 'barby/barcode/code_128'
require 'barby/barcode/qr_code'
require 'barby/outputter/prawn_outputter'
require 'barby/outputter/png_outputter'
require 'br_danfe'

require 'sefaz/base'
require 'sefaz/configuration'
require 'sefaz/exception'
require 'sefaz/refinement'
require 'sefaz/version'

require 'sefaz/utils/connection'
require 'sefaz/utils/prawn_helper'
require 'sefaz/utils/signer'
require 'sefaz/webservice/base'

require 'sefaz/webservice/nfe/client'
require 'sefaz/webservice/nfe/templates/base'
require 'sefaz/webservice/nfe/templates/evento_cancelamento'
require 'sefaz/webservice/nfe/templates/evento_carta_correcao'
require 'sefaz/webservice/nfe/templates/evento_inutilizacao'
require 'sefaz/webservice/nfe/auditor'
require 'sefaz/webservice/nfe/connection'
require 'sefaz/webservice/nfe/dataset'
require 'sefaz/webservice/nfe/validator'
require 'sefaz/webservice/nfe/wsdl'

require 'sefaz/webservice/sat/client'
require 'sefaz/webservice/sat/templates/base'
require 'sefaz/webservice/sat/templates/cupom_fiscal_55mm'
require 'sefaz/webservice/sat/templates/cupom_fiscal_80mm'
require 'sefaz/webservice/sat/dataset/cancel'
require 'sefaz/webservice/sat/dataset/sale'

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
