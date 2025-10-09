# frozen_string_literal: true

module SEFAZ
  module Webservice
    module NFE
      module Templates
        # Template para Evento de Cancelamento em PDF
        class EventoCancelamento < SEFAZ::Webservice::NFE::Templates::Base

          def build(doc, hash)
            doc.font_size 10

            chNFe = hash[:procEventoNFe][:evento][:infEvento][:chNFe]
            id = hash[:procEventoNFe][:evento][:infEvento][:@Id].delete('^0-9')
            nProt = hash[:procEventoNFe][:evento][:infEvento][:detEvento][:nProt]
            nProtCancelamento = hash[:procEventoNFe][:retEvento][:infEvento][:nProt]
            dhEvento = hash[:procEventoNFe][:evento][:infEvento][:dhEvento].to_time.strftime("%d/%m/%Y %H:%M:%S")
            dhRegEvento = hash[:procEventoNFe][:retEvento][:infEvento][:dhRegEvento].to_time.strftime("%d/%m/%Y %H:%M:%S")
            xJust = hash[:procEventoNFe][:evento][:infEvento][:detEvento][:xJust]
            xMotivo = hash[:procEventoNFe][:retEvento][:infEvento][:xMotivo]
            nSeqEvento = hash[:procEventoNFe][:evento][:infEvento][:nSeqEvento]
            cOrgao = hash[:procEventoNFe][:retEvento][:infEvento][:cOrgao]
            chNFeBlob = Barby::PngOutputter.new(Barby::Code128C.new(chNFe)).to_png(xdim: 1, height: 40, margin: 3)
            idBlob = Barby::PngOutputter.new(Barby::Code128C.new(id)).to_png(xdim: 1, height: 40, margin: 3)

            header = [[{ content: "Cancelamento de NF-e", align: :center, font_style: :bold, size: 18, padding: [15, 0] }]]
            body = [
              [{ content: "Chave de Acesso - NF-e", align: :center, size: 12, borders: [:top, :left, :right], padding: [5, 0, 0, 0], width: doc.bounds.width / 2 }, { content: "Chave de Acesso Cancelamento - NF-e", align: :center, size: 12, borders: [:top, :left, :right], padding: [5, 0, 0, 0], width: doc.bounds.width / 2 }],
              [{ content: chNFe, align: :center, borders: [:bottom, :left, :right], padding: [0, 0, 5, 0] }, { content: id, align: :center, borders: [:bottom, :left, :right], padding: [0, 0, 5, 0], size: 9 }],
              [{ image: StringIO.new(chNFeBlob), scale: 0.7, position: :center, vposition: :center, width: doc.bounds.width / 2 }, { image: StringIO.new(idBlob), scale: 0.7, position: :center, vposition: :center, width: doc.bounds.width / 2 }],
              [{ content: "Protocolo de Autorização NF-e\n#{nProt}", align: :center }, { content: "Protocolo de Cancelamento\n#{nProtCancelamento}", align: :center }],
              [{ content: "Data e Hora do Pedido de Cancelamento\n#{dhEvento}", align: :center }, { content: "Data e Hora do Registro de Cancelamento\n#{dhRegEvento}", align: :center }],
              [{ content: "Justificativa", colspan: 2, align: :center, borders: [:top, :left, :right], padding: [5, 0] }],
              [{ content: xJust, colspan: 2, align: :left, borders: [:bottom, :left, :right], padding: [5, 5], height: 100 }]
            ]

            footer = [
              [{ content: "Motivo", align: :center, borders: [:top, :left, :right], padding: [5, 0] }, { content: "Sequência", align: :center, borders: [:top, :left, :right], padding: [5, 0] }, { content: "Orgão", align: :center, borders: [:top, :left, :right], padding: [5, 0] }],
              [{ content: xMotivo, align: :center, borders: [:bottom, :left, :right], padding: [5, 0] }, { content: nSeqEvento, align: :center, borders: [:bottom, :left, :right], padding: [5, 0] }, { content: cOrgao, align: :center, borders: [:bottom, :left, :right], padding: [5, 0] }]
            ]

            [header, body, footer].each { |section| doc.table(section, width: doc.bounds.width) }
          end
        end
      end
    end
  end
end
