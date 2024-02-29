# frozen_string_literal: true

module SEFAZ
  module Webservice
    module SAT
      module Templates
        # Classe base dos templates para CFe-SAT
        class Base

          include SEFAZ::Utils::PrawnHelper

          def initialize
            @page_width = 0
            @margin = 0
            @page_break = 80.m
            @page_layout = :portrait
          end

          def build(doc, aut, canc, summary, infAdic)
            raise SEFAZ::NotImplemented, "Você deve implementar o método 'build' em uma subclasse."
          end

          def render(aut, canc, summary, infAdic)
            validation(aut, canc)

            Prawn::Document.new(page_size: [@page_width, @page_break], margin: @margin, page_layout: @page_layout) do |doc|
              build(doc, aut, canc, summary, infAdic)
              doc.page.dictionary.data[:MediaBox] = [0, (doc.y - @margin), @page_width, @page_break]
            end.render
          end

          private

            def validation(aut, canc)
              unless aut.is_a?(Hash) && aut.dig(:CFe, :Signature) && aut.dig(:CFe, :infCFe, :@Id) && 
                aut.dig(:CFe, :infCFe, :ide) && aut.dig(:CFe, :infCFe, :emit) && aut.dig(:CFe, :infCFe, :emit, :enderEmit) &&
                aut.dig(:CFe, :infCFe, :det) && aut.dig(:CFe, :infCFe, :total) && aut.dig(:CFe, :infCFe, :pgto)
                raise SEFAZ::ValidationError, "Layout do arquivo CFe-SAT inválido (Tipo de Arquivo: AUTORIZADO)."
              end

              if canc
                unless canc.is_a?(Hash) && canc.dig(:CFeCanc, :Signature) && canc.dig(:CFeCanc, :infCFe, :@Id) && canc.dig(:CFeCanc, :infCFe, :@chCanc) &&
                  canc.dig(:CFeCanc, :infCFe, :ide) && canc.dig(:CFeCanc, :infCFe, :emit) && canc.dig(:CFeCanc, :infCFe, :emit, :enderEmit) &&
                  canc.dig(:CFeCanc, :infCFe, :total) && (aut.dig(:CFe, :infCFe, :@Id) == canc.dig(:CFeCanc, :infCFe, :@chCanc))
                  raise SEFAZ::ValidationError, "Layout do arquivo CFe-SAT inválido (Tipo de Arquivo: CANCELAMENTO)."
                end
              end
            end

        end
      end
    end
  end
end
