# frozen_string_literal: true

module SEFAZ
  module Webservice
    module NFE
      module Templates
        # Template para Evento de Inutilização em PDF
        class EventoInutilizacao < SEFAZ::Webservice::NFE::Templates::Base

          def build(doc, hash)
            doc.font "Courier", style: :normal
            doc.font_size 12

            doc.text "Documento emitido por meio do software livre ruby-sefaz"
            doc.text hash.inspect
          end

        end
      end
    end
  end
end
