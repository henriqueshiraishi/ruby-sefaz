# frozen_string_literal: true

module SEFAZ
  module Webservice
    module SAT
      module Dataset
        # Principal classe de elaboração do XML de Cancelamento para o módulo CFe-SAT
        class Cancel

          attr_accessor :ide

          IDE = Struct.new(:CNPJ, :signAC, :numeroCaixa)

          def initialize(chCanc)
            @chCanc = chCanc
            @ide = IDE.new
          end

          def gerarCF
            hash = { CFeCanc: { infCFe: { :@chCanc => ("CFe" + @chCanc.to_s) } } }
            hash[:CFeCanc][:infCFe][:ide] = @ide.to_h
            hash[:CFeCanc][:infCFe][:emit] = {}
            hash[:CFeCanc][:infCFe][:dest] = {}
            hash[:CFeCanc][:infCFe][:total] = {}
            hash[:CFeCanc][:infCFe][:infAdic] = {}

            return [hash.to_xml!, hash]
          end

        end
      end
    end
  end
end
