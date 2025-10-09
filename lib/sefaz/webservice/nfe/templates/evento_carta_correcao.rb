# frozen_string_literal: true

module SEFAZ
  module Webservice
    module NFE
      module Templates
        # Template para Evento de Carta de Correção em PDF
        class EventoCartaCorrecao < SEFAZ::Webservice::NFE::Templates::Base

          def build(doc, hash)
            doc.font_size 9

            cnpj = hash[:procEventoNFe][:evento][:infEvento][:CNPJ].mask!("##.###.###/####-##")
            chNFe = hash[:procEventoNFe][:evento][:infEvento][:chNFe]
            nrNFe = chNFe[25..33].to_i
            serie = chNFe[22..24]
            modelo = chNFe[20..21]
            anomes = hash[:procEventoNFe][:evento][:infEvento][:dhEvento].to_date.strftime("%m/%y")
            nProt = hash[:procEventoNFe][:retEvento][:infEvento][:nProt]
            dhRegEvento = hash[:procEventoNFe][:retEvento][:infEvento][:dhRegEvento].to_time.strftime("%d/%m/%Y %H:%M:%S")
            nSeqEvento = hash[:procEventoNFe][:retEvento][:infEvento][:nSeqEvento]
            cOrgao = hash[:procEventoNFe][:retEvento][:infEvento][:cOrgao]
            xCorrecao = hash[:procEventoNFe][:evento][:infEvento][:detEvento][:xCorrecao]
            xCondUso = hash[:procEventoNFe][:evento][:infEvento][:detEvento][:xCondUso]
            chNFeBlob = Barby::PngOutputter.new(Barby::Code128C.new(chNFe)).to_png(xdim: 1, height: 40, margin: 3)

            header = [
              [{ content: "CNPJ: #{cnpj}", size: 10, align: :center, valign: :center, width: doc.bounds.width / 2 }, { content: "CCe", align: :center, font_style: :bold, size: 18, borders: [:top, :left, :right], padding: [15, 0, 0, 0], width: doc.bounds.width / 2 }],
              [{ content: nil, borders: [:top, :left] }, { content: "CARTA DE CORREÇÃO ELETRÔNICA", size: 10, align: :center, borders: [:bottom, :left, :right], padding: [0, 0, 15, 0] }],
              [{ content: nil, borders: [:left] }, { content: "Chave de Acesso da NFe", borders: [:top, :left, :right], padding: [5, 0, 0, 5] }],
              [{ content: nil, borders: [:left] }, { content: chNFe, size: 10, borders: [:bottom, :left, :right], padding: [0, 0, 5, 5] }],
              [{ content: nil, borders: [:bottom, :left] }, { image: StringIO.new(chNFeBlob), scale: 0.7, position: :center, vposition: :center }],
            ]

            body = [
              [{ content: "Número da Nota Fiscal", padding: [5, 0, 0, 0], align: :center, borders: [:top, :left, :right] }, { content: "Série", padding: [5, 0, 0, 0], align: :center, borders: [:top, :left, :right] }, { content: "Modelo", padding: [5, 0, 0, 0], align: :center, borders: [:top, :left, :right] }, { content: "Mês / Ano Emissão", padding: [5, 0, 0, 0], align: :center, borders: [:top, :left, :right] }],
              [{ content: nrNFe.to_s, padding: [0, 0, 5, 0], align: :center, borders: [:bottom, :left, :right] }, { content: serie, padding: [0, 0, 5, 0], align: :center, borders: [:bottom, :left, :right] }, { content: modelo, padding: [0, 0, 5, 0], align: :center, borders: [:bottom, :left, :right] }, { content: anomes, padding: [0, 0, 5, 0], align: :center, borders: [:bottom, :left, :right] }],
              [{ content: "Protocolo de Autorização - CCe", padding: [5, 0, 0, 0], align: :center, borders: [:top, :left, :right] }, { content: "Data de Autorização", padding: [5, 0, 0, 0], align: :center, borders: [:top, :left, :right] }, { content: "Sequência", padding: [5, 0, 0, 0], align: :center, borders: [:top, :left, :right] }, { content: "Orgão", padding: [5, 0, 0, 0], align: :center, borders: [:top, :left, :right] }],
              [{ content: nProt, padding: [0, 0, 5, 0], align: :center, borders: [:bottom, :left, :right] }, { content: dhRegEvento, padding: [0, 0, 5, 0], align: :center, borders: [:bottom, :left, :right] }, { content: nSeqEvento, padding: [0, 0, 5, 0], align: :center, borders: [:bottom, :left, :right] }, { content: cOrgao, padding: [0, 0, 5, 0], align: :center, borders: [:bottom, :left, :right] }],
              [{ content: "Correção:\n#{xCorrecao}", colspan: 4, padding: 5, height: 350 }],
              [{ content: xCondUso, colspan: 4, padding: 5, size: 8, align: :justify }],
            ]

            [header, body].each do |section|
              doc.table(section, width: doc.bounds.width)
              doc.move_down 5
            end
          end

        end
      end
    end
  end
end
