# frozen_string_literal: true

module SEFAZ
  module Webservice
    module NFE
      module Templates
        # Classe base dos templates para NFe
        class Base

          include SEFAZ::Utils::PrawnHelper

          def initialize
            @margin = 7.mm
            @page_size = 'A4'
            @page_layout = :portrait
          end

          def build(doc, hash)
            raise SEFAZ::NotImplemented, "Você deve implementar o método 'build' em uma subclasse."
          end

          def render(hash)
            Prawn::Document.new(page_size: @page_size, margin: @margin, page_layout: @page_layout) do |doc|
              build(doc, hash)
            end.render
          end

        end
      end
    end
  end
end
