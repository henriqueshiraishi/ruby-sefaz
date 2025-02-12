# frozen_string_literal: true

module SEFAZ
  module Webservice
    module SAT
      module Dataset
        # Principal classe de elaboração do XML de Venda para o módulo CFe-SAT
        class Sale
  
          attr_accessor :ide, :emit, :dest, :entrega, :det, :obsfiscodet, :total, :pgto, :mp, :infAdic
  
          IDE = Struct.new("IDE", :CNPJ, :signAC, :numeroCaixa)
          EMIT = Struct.new("EMIT", :CNPJ, :IE, :IM, :cRegTribISSQN, :indRatISSQN)
          DEST = Struct.new("DEST", :CNPJ, :CPF, :xNome)
          ENTREGA = Struct.new("ENTREGA", :xLgr, :nro, :xCpl, :xBairro, :xMun, :UF)
          DET = Struct.new("DET", :@nItem, :prod, :imposto, :infAdProd)
          PROD = Struct.new("PROD", :cProd, :cEAN, :xProd, :NCM, :CEST, :CFOP, :uCom, :qCom, :vUnCom, :indRegra, :vDesc, :vOutro, :obsFiscoDet, :cANP)
          OBSFISCODET = Struct.new("OBSFISCODET", :xCampoDet, :xTextoDet)
          IMPOSTO = Struct.new("IMPOSTO", :vItem12741, :ICMS, :PIS, :PISST, :COFINS, :COFINSST, :ISSQN)
          ICMS = Struct.new("ICMS", :ICMS00, :ICMS40, :ICMSSN102, :ICMSSN900)
          ICMS00 = Struct.new("ICMS00", :Orig, :CST, :pICMS)
          ICMS40 = Struct.new("ICMS40", :Orig, :CST)
          ICMSSN102 = Struct.new("ICMSSN102", :Orig, :CSOSN)
          ICMSSN900 = Struct.new("ICMSSN900", :Orig, :CSOSN, :pICMS)
          PIS = Struct.new("PIS", :PISAliq, :PISQtde, :PISNT, :PISSN, :PISOutr)
          PISAliq = Struct.new("PISAliq", :CST, :vBC, :pPIS)
          PISQtde = Struct.new("PISQtde", :CST, :qBCProd, :vAliqProd)
          PISNT = Struct.new("PISNT", :CST)
          PISSN = Struct.new("PISSN", :CST)
          PISOutr = Struct.new("PISOutr", :CST, :vBC, :pPIS, :qBCProd, :vAliqProd)
          PISST = Struct.new("PISST", :vBC, :pPIS, :qBCProd, :vAliqProd)
          COFINS = Struct.new("COFINS", :COFINSAliq, :COFINSQtde, :COFINSNT, :COFINSSN, :COFINSOutr)
          COFINSAliq = Struct.new("COFINSAliq", :CST, :vBC, :pCOFINS)
          COFINSQtde = Struct.new("COFINSQtde", :CST, :qBCProd, :vAliqProd)
          COFINSNT = Struct.new("COFINSNT", :CST)
          COFINSSN = Struct.new("COFINSSN", :CST)
          COFINSOutr = Struct.new("COFINSOutr", :CST, :vBC, :pCOFINS, :qBCProd, :vAliqProd)
          COFINSST = Struct.new("COFINSST", :vBC, :pCOFINS, :qBCProd, :vAliqProd)
          ISSQN = Struct.new("ISSQN", :vDeducISSQN, :vAliq, :cMunFG, :cListServ, :cServTribMun, :cNatOp, :indIncFisc)
          TOTAL = Struct.new("TOTAL", :DescAcrEntr, :vCFeLei12741)
          DescAcrEntr = Struct.new("DescAcrEntr", :vDescSubtot, :vAcresSubtot)
          PGTO = Struct.new("PGTO", :MP)
          MP = Struct.new("MP", :cMP, :vMP, :cAdmC, :cAut)
          INFADIC = Struct.new("INFADIC", :infCpl)
  
          def initialize
            @versaoDadosEnt = "0.08"
  
            @ide = IDE.new
            @emit = EMIT.new
            @dest = DEST.new
            @entrega = ENTREGA.new
            @total = TOTAL.new
            @total.DescAcrEntr = DescAcrEntr.new
            @pgto = PGTO.new
            @pgto.MP = []
            @infAdic = INFADIC.new
  
            @listas = {}
            @listas[:det] = []
          end
  
          def gerarCF
            # Raiz = CFe
            # A01 = infCFe
            # H01 = det
            # I01 = prod
            # M01 = imposto
            # N01 = ICMS
            hash = { CFe: { infCFe: { :@versaoDadosEnt => @versaoDadosEnt } } }
            hash[:CFe][:infCFe][:ide] = @ide.to_h
            hash[:CFe][:infCFe][:emit] = @emit.to_h
            hash[:CFe][:infCFe][:dest] = @dest.to_h
            hash[:CFe][:infCFe][:entrega] = @entrega.to_h
            hash[:CFe][:infCFe][:det] = @listas[:det]
            hash[:CFe][:infCFe][:total] = @total.to_h
            hash[:CFe][:infCFe][:total][:DescAcrEntr] = @total.DescAcrEntr.to_h
            hash[:CFe][:infCFe][:pgto] = @pgto.to_h
            hash[:CFe][:infCFe][:infAdic] = @infAdic.to_h
            compressed = hash.compress!
  
            return [compressed.to_xml!, compressed]
          end
  
          def add(part_name)
            part_object = case part_name
            when "DET"
              @det = DET.new
              @det.prod = PROD.new
              @det.prod.obsFiscoDet = []
              @det.imposto = IMPOSTO.new
              @det.imposto.ICMS = ICMS.new
              @det.imposto.ICMS.ICMS00 = ICMS00.new
              @det.imposto.ICMS.ICMS40 = ICMS40.new
              @det.imposto.ICMS.ICMSSN102 = ICMSSN102.new
              @det.imposto.ICMS.ICMSSN900 = ICMSSN900.new
              @det.imposto.PIS = PIS.new
              @det.imposto.PIS.PISAliq = PISAliq.new
              @det.imposto.PIS.PISQtde = PISQtde.new
              @det.imposto.PIS.PISNT = PISNT.new
              @det.imposto.PIS.PISSN = PISSN.new
              @det.imposto.PIS.PISOutr = PISOutr.new
              @det.imposto.PISST = PISST.new
              @det.imposto.COFINS = COFINS.new
              @det.imposto.COFINS.COFINSAliq = COFINSAliq.new
              @det.imposto.COFINS.COFINSQtde = COFINSQtde.new
              @det.imposto.COFINS.COFINSNT = COFINSNT.new
              @det.imposto.COFINS.COFINSSN = COFINSSN.new
              @det.imposto.COFINS.COFINSOutr = COFINSOutr.new
              @det.imposto.COFINSST = COFINSST.new
              @det.imposto.ISSQN = ISSQN.new
              @det
            when "OBSFISCODET"
              @obsfiscodet = OBSFISCODET.new
              @obsfiscodet
            when "MP"
              @mp = MP.new
              @mp
            end
  
            if block_given?
              yield(part_object)
              save(part_name)
            end
  
            nil
          end
  
          def save(part_name)
            case part_name
            when "DET"
              if @det.is_a?(Struct::DET)
                item = @det
                item.prod = item.prod.to_h
                item.imposto.ICMS.ICMS00 = item.imposto.ICMS.ICMS00.to_h
                item.imposto.ICMS.ICMS40 = item.imposto.ICMS.ICMS40.to_h
                item.imposto.ICMS.ICMSSN102 = item.imposto.ICMS.ICMSSN102.to_h
                item.imposto.ICMS.ICMSSN900 = item.imposto.ICMS.ICMSSN900.to_h
                item.imposto.ICMS = item.imposto.ICMS.to_h
                item.imposto.PIS.PISAliq = item.imposto.PIS.PISAliq.to_h
                item.imposto.PIS.PISQtde = item.imposto.PIS.PISQtde.to_h
                item.imposto.PIS.PISNT = item.imposto.PIS.PISNT.to_h
                item.imposto.PIS.PISSN = item.imposto.PIS.PISSN.to_h
                item.imposto.PIS.PISOutr = item.imposto.PIS.PISOutr.to_h
                item.imposto.PIS = item.imposto.PIS.to_h
                item.imposto.PISST = item.imposto.PISST.to_h
                item.imposto.COFINS.COFINSAliq = item.imposto.COFINS.COFINSAliq.to_h
                item.imposto.COFINS.COFINSQtde = item.imposto.COFINS.COFINSQtde.to_h
                item.imposto.COFINS.COFINSNT = item.imposto.COFINS.COFINSNT.to_h
                item.imposto.COFINS.COFINSSN = item.imposto.COFINS.COFINSSN.to_h
                item.imposto.COFINS.COFINSOutr = item.imposto.COFINS.COFINSOutr.to_h
                item.imposto.COFINS = item.imposto.COFINS.to_h
                item.imposto.COFINSST = item.imposto.COFINSST.to_h
                item.imposto.ISSQN = item.imposto.ISSQN.to_h
                item.imposto = item.imposto.to_h
                item[:@nItem] = (@listas[:det].length + 1)
                @listas[:det].push(item.to_h)
              end
            when "OBSFISCODET"
              if @det.is_a?(Struct::DET) && @obsfiscodet.is_a?(Struct::OBSFISCODET)
                @det.prod.obsFiscoDet.push(@obsfiscodet.to_h)
              end
            when "MP"
              if @pgto.is_a?(Struct::PGTO) && @mp.is_a?(Struct::MP)
                @pgto.MP.push(@mp.to_h)
              end
            end
  
            nil
          end
  
        end
      end
    end
  end
end
