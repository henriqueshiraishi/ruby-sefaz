# frozen_string_literal: true

module SEFAZ
  module Webservice
    module SAT
      module Templates
        # Template para CFe-SAT 80mm em PDF
        class CupomFiscal80mm < SEFAZ::Webservice::SAT::Templates::Base

          def initialize
            super
            @page_width = Configuration.default.cfe_page_width_80mm
            @margin = Configuration.default.cfe_margin_55mm
          end

          def build(doc, aut, canc, summary, infAdic)
            doc.font "Courier", style: :normal
            doc.font_size 7

            infCFe = (canc ? canc.dig(:CFeCanc, :infCFe) : aut.dig(:CFe, :infCFe))
            header(doc, aut)
            body(doc, aut, summary, infCFe.dig(:@chCanc))
            footer(doc, infCFe, infAdic)
          end

          #
          # CABEÇALHO (Aut)
          #
          def header(doc, aut)
            emit = aut.dig(:CFe, :infCFe, :emit)
            enderEmit = aut.dig(:CFe, :infCFe, :emit, :enderEmit)

            # Dados do emitente
            doc.text emit.dig(:xFant).to_s.strip.upcase, align: :center
            doc.text emit.dig(:xNome).to_s.strip.upcase, align: :center
            doc.text "#{enderEmit.dig(:xLgr)} #{enderEmit.dig(:nro)} #{enderEmit.dig(:xCpl)} #{enderEmit.dig(:xBairro)} #{enderEmit.dig(:xMun)} #{enderEmit.dig(:CEP)}".to_s.strip.upcase, align: :center
            doc.move_down doc.font_size
            doc.text "CNPJ #{emit.dig(:CNPJ).to_s.mask!("##.###.###/####-##")} IE #{emit.dig(:IE).to_s.mask!("###.###.###.###")}".to_s.strip.upcase, align: :center
            doc.text "IM #{emit.dig(:IM).to_s.mask!("####.###.###.###")}".to_s.strip.upcase, align: :center if emit.dig(:IM)
          end

          #
          # CORPO DO EXTRATO (Aut)
          #
          # Exibe os dados de forma dinâmica:
          # Quando CFe Movimento: exibe lista dos itens a partir do XML AUTORIZADO (Resumido ou Não Resumido).
          # Quando CFe Cancelamento: exibe os dados do XML AUTORIZADO em modo cancelado.
          #
          def body(doc, aut, summary, chCanc)
            tpAmb = aut.dig(:CFe, :infCFe, :ide, :tpAmb)
            nCFe = (tpAmb == 1) ? aut.dig(:CFe, :infCFe, :ide, :nCFe) : "000000"

            # (I) - Título
            doc.move_down 1.mm
            doc.text "Extrato #{nCFe} do CUPOM FISCAL ELETRÔNICO - SAT", style: :bold, align: :center

            # (A) - Título - Cancelamento
            if chCanc
              doc.move_down 1.mm
              doc.text "CANCELAMENTO", style: :bold, align: :center
            end

            # (TESTE) Marca de Teste
            if tpAmb == "2"
              doc.move_down doc.font_size

              doc.text "= TESTE =", style: :italic, align: :center
              doc.move_down doc.font_size
              3.times do
                doc.text_box (">" * 100), at: [0, doc.cursor], height: doc.font_size, width: doc.bounds.width
                doc.move_down doc.font_size
                doc.move_down doc.font_size
              end
            end

            # Exibe o extrato no modo cancelado caso exista Chave de Cancelamento, caso contrário exibe no modo movimento
            if chCanc
              body_canceled_mode(doc, aut)
            else
              body_movement_mode(doc, aut, summary)
            end
          end

          #
          # CORPO DO EXTRATO > MODO MOVIMENTO (Aut)
          #
          # Exibe lista dos itens.
          #
          def body_movement_mode(doc, aut, summary)
            # (II) - Legenda
            doc.text "#|COD|DESC|QTD|UN|VL UN R$|(VL TR R$)*|VL ITEM R$", size: 6.7
            dash(doc, gap: 2, space: 0.5, line_width: 0.1, x1: 0, x2: doc.bounds.width, y: doc.cursor)

            # (III) - Registros de item
            unless summary
              det = aut.dig(:CFe, :infCFe, :det)
              det = det.is_a?(Array) ? det : [det]
              det.each do |i|
                # DADOS: #|COD|DESC|QTD|UN|VL UN R$|(VL TR R$)*
                doc.bounding_box([0, doc.cursor], width: (doc.bounds.width - 13.mm)) do
                  doc.text "#{i.dig(:@nItem)} #{i.dig(:prod, :cProd)} #{i.dig(:prod, :xProd)} #{i.dig(:prod, :qCom)} #{i.dig(:prod, :uCom)} X #{i.dig(:prod, :vUnCom).to_f.to_currency} (#{i.dig(:imposto, :vItem12741).to_f.to_currency})"
                end
  
                # DADOS: VL ITEM R$
                doc.move_down -doc.font_size
                doc.text i.dig(:prod, :vProd).to_f.to_currency, align: :right
  
                # DADOS: DESCONTO
                if i.dig(:prod, :vDesc).to_f > 0
                  doc.float { doc.text "-#{i.dig(:prod, :vDesc).to_f.to_currency}", align: :right }
                  doc.text "desconto sobre item"
                end
  
                # DADOS: ACRÉSCIMO
                if i.dig(:prod, :vOutro).to_f > 0
                  doc.float { doc.text "+#{i.dig(:prod, :vOutro).to_f.to_currency}", align: :right }
                  doc.text "acréscimo sobre item"
                end
  
                # DADOS: RATEIO DESCONTO
                if i.dig(:prod, :vRatDesc).to_f > 0
                  doc.float { doc.text "-#{i.dig(:prod, :vRatDesc).to_f.to_currency}", align: :right }
                  doc.text "rateio de desconto sobre subtotal"
                end
  
                # DADOS: RATEIO ACRÉSCIMO
                if i.dig(:prod, :vRatAcr).to_f > 0
                  doc.float { doc.text "+#{i.dig(:prod, :vRatAcr).to_f.to_currency}", align: :right }
                  doc.text "rateio de acréscimo sobre subtotal"
                end
  
                # DADOS: ISSQN
                if i.dig(:imposto, :ISSQN, :vDeducISSQN).to_f > 0
                  doc.float { doc.text "-#{i.dig(:imposto, :ISSQN, :vDeducISSQN).to_f.to_currency}", align: :right }
                  doc.text "dedução para ISSQN"
                  doc.float { doc.text i.dig(:imposto, :ISSQN, :vBC).to_f.to_currency, align: :right }
                  doc.text "base de cálculo ISSQN"
                end
              end
            end

            # (IV) - Total do Cupom
            total = aut.dig(:CFe, :infCFe, :total)

            # DADOS: VALOR BRUTO
            if (total.dig(:DescAcrEntr, :vDescSubtot).to_f > 0) || (total.dig(:DescAcrEntr, :vAcresSubtot).to_f > 0) || (total.dig(:ICMSTot, :vDesc).to_f > 0) || (total.dig(:ICMSTot, :vOutro).to_f > 0)
              doc.float { doc.text total.dig(:ICMSTot, :vProd).to_f.to_currency, align: :right }
              doc.text "Total bruto de itens"
            end

            # DADOS: TOTAL DESC/ACRES SOBRE ITENS
            if (total.dig(:ICMSTot, :vDesc).to_f > 0) || (total.dig(:ICMSTot, :vOutro).to_f > 0)
              valor11 = total.dig(:ICMSTot, :vOutro).to_f - total.dig(:ICMSTot, :vDesc).to_f
              doc.text "Total de descontos/acréscimos sobre item"
              doc.text "#{ valor11 > 0 ? '+' : '-' }#{valor11.abs.to_currency}", align: :right
            end

            # DADOS: DESCONTO SOBRE TOTAL
            if total.dig(:DescAcrEntr, :vDescSubtot).to_f > 0
              doc.float { doc.text "-#{total.dig(:DescAcrEntr, :vDescSubtot).to_f.to_currency}", align: :right }
              doc.text "Desconto sobre subtotal"
            end

            # DADOS: ACRÉSCIMO SOBRE TOTAL
            if total.dig(:DescAcrEntr, :vAcresSubtot).to_f > 0
              doc.float { doc.text "+#{total.dig(:DescAcrEntr, :vAcresSubtot).to_f.to_currency}", align: :right }
              doc.text "Acréscimo sobre subtotal"
            end

            # DADOS: TOTAL FINAL
            doc.float { doc.text total.dig(:vCFe).to_f.to_currency, style: :bold, align: :right }
            doc.text "Total R$", style: :bold

            # (V) - Meio de Pagamento
            pgto = aut.dig(:CFe, :infCFe, :pgto)
            mp = aut.dig(:CFe, :infCFe, :pgto, :MP)
            mp = mp.is_a?(Array) ? mp : [mp]
            mp.each do |i|
              # DADOS: DESCRIÇÃO MEIO DE PAGAMENTO
              doc.bounding_box([0, doc.cursor], width: (doc.bounds.width - 13.mm)) do
                doc.text Configuration.default.cfe_cMP_cod_desc[i.dig(:cMP)]
              end

              # DADOS: VALOR PAGAMENTO
              doc.move_down -doc.font_size
              doc.text i.dig(:vMP).to_f.to_currency, align: :right
            end

            # DADOS: TROCO
            doc.float { doc.text pgto.dig(:vTroco).to_f.to_currency, align: :right }
            doc.text "Troco R$"

            # (VI) - Observações do Fisco
            obsFisco = aut.dig(:CFe, :infCFe, :obsFisco)
            if obsFisco
              obsFisco = obsFisco.is_a?(Array) ? obsFisco : [obsFisco]
              obsFisco.each do |i|
                doc.text "#{i.dig(:xCampo)}: #{i.dig(:xTexto)}"
              end
            end

            # (VII) - Dados para Entrega
            entrega = aut.dig(:CFe, :infCFe, :entrega)
            doc.text "ENDEREÇO DE ENTREGA: #{entrega.dig(:xLgr)} #{entrega.dig(:nro)} #{entrega.dig(:xCpl)} #{entrega.dig(:xBairro)} #{entrega.dig(:xMun)} #{entrega.dig(:UF)}".to_s.strip.upcase if entrega

            # (VIII) - Observações do Contribuinte
            infCFe = aut.dig(:CFe, :infCFe)
            doc.text "OBSERVAÇÕES DO CONTRIBUINTE"
            doc.text infCFe.dig(:infCpl)
            doc.text "Valor aproximado dos tributos deste cupom R$"
            doc.text total.dig(:vCFeLei12741).to_f.to_currency, align: :right
            doc.text "(conforme Lei Fed. 12.741/2012)"
            doc.move_down doc.font_size
          end

          #
          # CORPO DO EXTRATO > MODO CANCELADO (Aut)
          #
          # Exibe os dados do XML AUTORIZADO em modo cancelado.
          # É renderizado o rodapé do XML AUTORIZADO no final do corpo do extrato.
          #
          def body_canceled_mode(doc, aut)
            total = aut.dig(:CFe, :infCFe, :total)
            infCFe = aut.dig(:CFe, :infCFe)

            # (B) - Dados do Cupom Fiscal Cancelado
            doc.move_down 1.mm
            doc.text "DADOS DO CUPOM ELETRÔNICO CANCELADO", style: :bold
            doc.text "TOTAL R$ #{total.dig(:vCFe).to_f.to_currency}"

            # (RODAPÉ DE MOVIMENTO) Exibe o rodapé do Extrato de Movimento no corpo do Extrato de Cancelamento
            footer(doc, infCFe, vl_aprox_trib: false)
          end

          #
          # RODAPÉ (Aut/Canc)
          #
          # Exibe os elementos de rodapé (QR Code, código de barras, número da chave, mensagens fixas, etc).
          # O método permite exibir o rodapé no modo movimento ou cancelado.
          #
          def footer(doc, infCFe, infAdic = nil, vl_aprox_trib: true)
            id = infCFe.dig(:@Id)
            chCanc = infCFe.dig(:@chCanc)
            ide = infCFe.dig(:ide)
            total = infCFe.dig(:total)

            # Título do cancelamento
            if chCanc
              doc.move_down 2
              dash(doc, gap: 2, space: 0.5, line_width: 0.1, x1: 0, x2: doc.bounds.width, y: doc.cursor)
              doc.text "DADOS DO CUPOM FISCAL ELETRÔNICO DE CANCELAMENTO", align: :center, style: :bold, size: 6.8
            end

            # Número da chave do Cupom Fiscal (dividos em 11 blocos com 4 números cada)
            doc.move_down 2
            doc.text id.to_s.delete("^0-9").scan(/.{4}/).join("  "), align: :center, style: :bold
            doc.move_down doc.font_size

            # Código de barra CODE 128-C (divido em duas partes)
            barcode_128c(doc, value: id.to_s.delete("^0-9"), x: 0, y: doc.cursor, xdim: 0.72)
            doc.move_down 1.mm

            # Informação do consumidor, SAT e mensagens fixas
            doc.float do
              doc.move_down 5.mm
              doc.bounding_box([80, doc.cursor], width: 115) do
                # Informação do consumidor (CNPJ/CPF e NOME)
                if !chCanc && (infCFe.dig(:dest, :CNPJ) || infCFe.dig(:dest, :CPF))
                  info = "<b>Consumidor:</b> "
                  info = info + infCFe.dig(:dest, :CNPJ).to_s.mask!("##.###.###/####-##") if infCFe.dig(:dest, :CNPJ)
                  info = info + infCFe.dig(:dest, :CPF).to_s.mask!("###.###.###-##") if infCFe.dig(:dest, :CPF)
                  doc.text info, inline_format: true, size: 6
                  doc.text infCFe.dig(:dest, :xNome), size: 6 if infCFe.dig(:dest, :xNome)
                end

                # Informação do SAT (Nº Série SAT)
                doc.text "<b>No. Serie do SAT:</b> #{ide.dig(:nserieSAT)}", inline_format: true, size: 6
                doc.text DateTime.parse("#{ide.dig(:dEmi)}T#{ide.dig(:hEmi)}").strftime("%d/%m/%Y - %H:%M:%S"), size: 6
                doc.move_down doc.font_size

                # Mensagens fixas do Cupom Fiscal
                if !chCanc
                  doc.text "Consulte o QR Code pelo aplicativo \"#{Configuration.default.cfe_qr_code_aplicativo}\", disponível na AppStore (Apple) e PlayStore (Android)", size: 6
                  doc.move_down doc.font_size
                  doc.text "*valor aproximado dos tributos do item", size: 5 if vl_aprox_trib
                end
              end
            end

            # QR Code do Cupom Fiscal = Id|(dEmi)(hEmi)|vCFe|(CNPJ/CPF)|assinaturaQRCODE
            doc.move_down 2.mm
            codigo_qr_code = "#{id}|#{ide.dig(:dEmi)}#{ide.dig(:hEmi)}|#{total.dig(:vCFe)}|#{(infCFe.dig(:dest, :CNPJ) || infCFe.dig(:dest, :CPF))}|#{ide.dig(:assinaturaQRCODE)}"
            qrcode(doc, value: codigo_qr_code, x: 0, y: doc.cursor)
            doc.move_down 3.mm

            # Informações adicionais do Cupom Fiscal (customizado pelo contribuinte)
            if infAdic
              dash(doc, gap: 2, space: 0.5, line_width: 0.1, x1: 0, x2: doc.bounds.width, y: doc.cursor)
              doc.text infAdic, align: :justify, size: 6
            end
          end

        end
      end
    end
  end
end
