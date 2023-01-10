# frozen_string_literal: true

module SEFAZ
  module Utils
    module WSDL

      # Ambiente: 1=Produção; 2=Homologação
      # Serviços:
      # - :NfeInutilizacao
      # - :NfeConsultaProtocolo
      # - :NfeStatusServico
      # - :NfeConsultaCadastro
      # - :RecepcaoEvento
      # - :NFeAutorizacao
      # - :NFeRetAutorizacao
      # UF: código IBGE do Estado
  
      # Método que retorna versão e a URL wsdl da SEFAZ
      # Exemplo de consumo:
      # @versao, @wsdl = SEFAZ::Utils::WSDL.get(:NfeStatusServico, "1", "35")
      def self.get(servico, ambiente, uf)
        case uf.to_s
        when "13"; SEFAZ::Utils::WSDL.wsdl_am(ambiente.to_s)[servico.to_sym] # Sefaz Amazonas - (AM)
        when "29"; SEFAZ::Utils::WSDL.wsdl_ba(ambiente.to_s)[servico.to_sym] # Sefaz Bahia - (BA)
        # when "52"; SEFAZ::Utils::WSDL.wsdl_go(ambiente.to_s)[servico.to_sym] # Sefaz Goias - (GO)
        # when "31"; SEFAZ::Utils::WSDL.wsdl_mg(ambiente.to_s)[servico.to_sym] # Sefaz Minas Gerais - (MG)
        # when "50"; SEFAZ::Utils::WSDL.wsdl_ms(ambiente.to_s)[servico.to_sym] # Sefaz Mato Grosso do Sul - (MS)
        # when "51"; SEFAZ::Utils::WSDL.wsdl_mt(ambiente.to_s)[servico.to_sym] # Sefaz Mato Grosso - (MT)
        # when "26"; SEFAZ::Utils::WSDL.wsdl_pe(ambiente.to_s)[servico.to_sym] # Sefaz Pernambuco - (PE)
        # when "41"; SEFAZ::Utils::WSDL.wsdl_pr(ambiente.to_s)[servico.to_sym] # Sefaz Paraná - (PR)
        # when "43"; SEFAZ::Utils::WSDL.wsdl_rs(ambiente.to_s)[servico.to_sym] # Sefaz Rio Grande do Sul - (RS)
        when "35"; SEFAZ::Utils::WSDL.wsdl_sp(ambiente.to_s)[servico.to_sym] # Sefaz São Paulo - (SP)
        end
      end
  
      # Sefaz Amazonas - (AM)
      def self.wsdl_am(ambiente)
        case ambiente
        when "1"
          {
            NfeInutilizacao:        ["4.00", "https://nfe.sefaz.am.gov.br/services2/services/NfeInutilizacao4?wsdl"],
            NfeConsultaProtocolo:   ["4.00", "https://nfe.sefaz.am.gov.br/services2/services/NfeConsulta4?wsdl"],
            NfeStatusServico:       ["4.00", "https://nfe.sefaz.am.gov.br/services2/services/NfeStatusServico4?wsdl"],
            RecepcaoEvento:         ["4.00", "https://nfe.sefaz.am.gov.br/services2/services/RecepcaoEvento4?wsdl"],
            NFeAutorizacao:         ["4.00", "https://nfe.sefaz.am.gov.br/services2/services/NfeAutorizacao4?wsdl"],
            NFeRetAutorizacao:      ["4.00", "https://nfe.sefaz.am.gov.br/services2/services/NfeRetAutorizacao4?wsdl"]
          }
        when "2"
          {
            NfeInutilizacao:        ["4.00", "https://homnfe.sefaz.am.gov.br/services2/services/NfeInutilizacao4?wsdl"],
            NfeConsultaProtocolo:   ["4.00", "https://homnfe.sefaz.am.gov.br/services2/services/NfeConsulta4?wsdl"],
            NfeStatusServico:       ["4.00", "https://homnfe.sefaz.am.gov.br/services2/services/NfeStatusServico4?wsdl"],
            RecepcaoEvento:         ["4.00", "https://homnfe.sefaz.am.gov.br/services2/services/RecepcaoEvento4?wsdl"],
            NFeAutorizacao:         ["4.00", "https://homnfe.sefaz.am.gov.br/services2/services/NfeAutorizacao4?wsdl"],
            NFeRetAutorizacao:      ["4.00", "https://homnfe.sefaz.am.gov.br/services2/services/NfeRetAutorizacao4?wsdl"]
          }
        end
      end
  
      # Sefaz Bahia - (BA)
      def self.wsdl_ba(ambiente)
        case ambiente
        when "1"
          {
            NfeInutilizacao:        ["4.00", "https://nfe.sefaz.ba.gov.br/webservices/NFeInutilizacao4/NFeInutilizacao4.asmx?wsdl"],
            NfeConsultaProtocolo:   ["4.00", "https://nfe.sefaz.ba.gov.br/webservices/NFeConsultaProtocolo4/NFeConsultaProtocolo4.asmx?wsdl"],
            NfeStatusServico:       ["4.00", "https://nfe.sefaz.ba.gov.br/webservices/NFeStatusServico4/NFeStatusServico4.asmx?wsdl"],
            NfeConsultaCadastro:    ["4.00", "https://nfe.sefaz.ba.gov.br/webservices/CadConsultaCadastro4/CadConsultaCadastro4.asmx?wsdl"],
            RecepcaoEvento:         ["4.00", "https://nfe.sefaz.ba.gov.br/webservices/NFeRecepcaoEvento4/NFeRecepcaoEvento4.asmx?wsdl"],
            NFeAutorizacao:         ["4.00", "https://nfe.sefaz.ba.gov.br/webservices/NFeAutorizacao4/NFeAutorizacao4.asmx?wsdl"],
            NFeRetAutorizacao:      ["4.00", "https://nfe.sefaz.ba.gov.br/webservices/NFeRetAutorizacao4/NFeRetAutorizacao4.asmx?wsdl"]
          }
        when "2"
          {
            NfeInutilizacao:        ["4.00", "https://hnfe.sefaz.ba.gov.br/webservices/NFeInutilizacao4/NFeInutilizacao4.asmx?wsdl"],
            NfeConsultaProtocolo:   ["4.00", "https://hnfe.sefaz.ba.gov.br/webservices/NFeConsultaProtocolo4/NFeConsultaProtocolo4.asmx?wsdl"],
            NfeStatusServico:       ["4.00", "https://hnfe.sefaz.ba.gov.br/webservices/NFeStatusServico4/NFeStatusServico4.asmx?wsdl"],
            NfeConsultaCadastro:    ["4.00", "https://hnfe.sefaz.ba.gov.br/webservices/CadConsultaCadastro4/CadConsultaCadastro4.asmx?wsdl"],
            RecepcaoEvento:         ["4.00", "https://hnfe.sefaz.ba.gov.br/webservices/NFeRecepcaoEvento4/NFeRecepcaoEvento4.asmx?wsdl"],
            NFeAutorizacao:         ["4.00", "https://hnfe.sefaz.ba.gov.br/webservices/NFeAutorizacao4/NFeAutorizacao4.asmx?wsdl"],
            NFeRetAutorizacao:      ["4.00", "https://hnfe.sefaz.ba.gov.br/webservices/NFeRetAutorizacao4/NFeRetAutorizacao4.asmx?wsdl"]
          }
        end
      end
  
      # Sefaz São Paulo - (SP)
      def self.wsdl_sp(ambiente)
        case ambiente
        when "1"
          {
            NfeInutilizacao:        ["4.00", "https://nfe.fazenda.sp.gov.br/ws/nfeinutilizacao4.asmx?wsdl"],
            NfeConsultaProtocolo:   ["4.00", "https://nfe.fazenda.sp.gov.br/ws/nfeconsultaprotocolo4.asmx?wsdl"],
            NfeStatusServico:       ["4.00", "https://nfe.fazenda.sp.gov.br/ws/nfestatusservico4.asmx?wsdl"],
            NfeConsultaCadastro:    ["4.00", "https://nfe.fazenda.sp.gov.br/ws/cadconsultacadastro4.asmx?wsdl"],
            RecepcaoEvento:         ["4.00", "https://nfe.fazenda.sp.gov.br/ws/nferecepcaoevento4.asmx?wsdl"],
            NFeAutorizacao:         ["4.00", "https://nfe.fazenda.sp.gov.br/ws/nfeautorizacao4.asmx?wsdl"],
            NFeRetAutorizacao:      ["4.00", "https://nfe.fazenda.sp.gov.br/ws/nferetautorizacao4.asmx?wsdl"]
          }
        when "2"
          {
            NfeInutilizacao:        ["4.00", "https://homologacao.nfe.fazenda.sp.gov.br/ws/nfeinutilizacao4.asmx?wsdl"],
            NfeConsultaProtocolo:   ["4.00", "https://homologacao.nfe.fazenda.sp.gov.br/ws/nfeconsultaprotocolo4.asmx?wsdl"],
            NfeStatusServico:       ["4.00", "https://homologacao.nfe.fazenda.sp.gov.br/ws/nfestatusservico4.asmx?wsdl"],
            NfeConsultaCadastro:    ["4.00", "https://homologacao.nfe.fazenda.sp.gov.br/ws/cadconsultacadastro4.asmx?wsdl"],
            RecepcaoEvento:         ["4.00", "https://homologacao.nfe.fazenda.sp.gov.br/ws/nferecepcaoevento4.asmx?wsdl"],
            NFeAutorizacao:         ["4.00", "https://homologacao.nfe.fazenda.sp.gov.br/ws/nfeautorizacao4.asmx?wsdl"],
            NFeRetAutorizacao:      ["4.00", "https://homologacao.nfe.fazenda.sp.gov.br/ws/nferetautorizacao4.asmx?wsdl"]
          }
        end
      end
  
    end
  end
end
