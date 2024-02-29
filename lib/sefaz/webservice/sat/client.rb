# frozen_string_literal: true

module SEFAZ
  module Webservice
    module SAT
      # Principal classe de integração com o módulo CFe-SAT
      class Client < SEFAZ::Webservice::Base

        SERVICES = %i[ exportarCF ]

        def initialize
        end

        # Exportar CFe (Cupom Fiscal Eletrônico) no formato PDF
        # Para gerar o CFe de Cancelamento, é obrigatório informar o @canc (CFe de Cancelmaneto) junto com o @aut (CFe de Movimento)
        #
        # Exemplo de CFe de Movimento:
        # @pdf = @client.exportarCF(80, aut: @aut, infAdic: "Participe da Promoção de Natal.")
        #
        # Exemplo de CFe de Cancelmaneto:
        # @pdf = @client.exportarCF(80, aut: @aut, canc: @canc, infAdic: "Participe da Promoção de Natal.")
        #
        # @mm(Integer) = Milímetro da bobina termica para gerar o documento PDF (opções=55,80)
        # @aut(Hash ou String) = XML ou Hash - Autorizado
        # @canc(Hash ou String) = XML ou Hash - Cancelamento (OPCIONAL)
        # @summary(Boolean) = Exibir Extrato de Movimento no formato resumido (OPCIONAL)
        # @infAdic(String) = Informações adicionais de rodapé do CFe (OPCIONAL)
        def exportarCF(mm, aut:, canc: nil, summary: false, infAdic: nil)
          aut = (aut.is_a?(Hash) ? aut : aut.to_hash!)
          canc = (canc.is_a?(Hash) ? canc : canc.to_hash!) if canc
          case mm
          when 55
            SEFAZ::Webservice::SAT::Templates::CupomFiscal55mm.new.render(aut, canc, summary, infAdic)
          when 80
            SEFAZ::Webservice::SAT::Templates::CupomFiscal80mm.new.render(aut, canc, summary, infAdic)
          else
            SEFAZ::Webservice::SAT::Templates::Base.new.render(aut, canc, summary, infAdic)
          end
        end

      end
    end
  end
end
