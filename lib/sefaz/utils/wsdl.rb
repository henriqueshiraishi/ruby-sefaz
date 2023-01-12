# frozen_string_literal: true

module SEFAZ
  module Utils
    module WSDL

      # Ambiente: 1=Produção; 2=Homologação
      # Operações:
      # - :NfeInutilizacao
      # - :NfeConsultaProtocolo - OK (consultarNF)
      # - :NfeStatusServico     - OK (statusDoServico)
      # - :NfeConsultaCadastro  - OK (consultarCadastro)
      # - :RecepcaoEvento
      # - :NFeAutorizacao
      # - :NFeRetAutorizacao    - OK (consultarRecibo)
      # UF: código IBGE do Estado
  
      # Método retorna a URL wsdl da SEFAZ, exemplo de consumo:
      # @wsdl = SEFAZ::Utils::WSDL.get(:NfeStatusServico, "1", "35")

      def self.get(operacao, ambiente, uf)
        case uf.to_s
        when "13"; SEFAZ::Utils::WSDL.wsdl_am(ambiente.to_s)[operacao.to_sym] # Sefaz Amazonas - (AM)
        when "29"; SEFAZ::Utils::WSDL.wsdl_ba(ambiente.to_s)[operacao.to_sym] # Sefaz Bahia - (BA)
        # when "52"; SEFAZ::Utils::WSDL.wsdl_go(ambiente.to_s)[operacao.to_sym] # Sefaz Goias - (GO)
        # when "31"; SEFAZ::Utils::WSDL.wsdl_mg(ambiente.to_s)[operacao.to_sym] # Sefaz Minas Gerais - (MG)
        # when "50"; SEFAZ::Utils::WSDL.wsdl_ms(ambiente.to_s)[operacao.to_sym] # Sefaz Mato Grosso do Sul - (MS)
        # when "51"; SEFAZ::Utils::WSDL.wsdl_mt(ambiente.to_s)[operacao.to_sym] # Sefaz Mato Grosso - (MT)
        # when "26"; SEFAZ::Utils::WSDL.wsdl_pe(ambiente.to_s)[operacao.to_sym] # Sefaz Pernambuco - (PE)
        # when "41"; SEFAZ::Utils::WSDL.wsdl_pr(ambiente.to_s)[operacao.to_sym] # Sefaz Paraná - (PR)
        # when "43"; SEFAZ::Utils::WSDL.wsdl_rs(ambiente.to_s)[operacao.to_sym] # Sefaz Rio Grande do Sul - (RS)
        when "35"; SEFAZ::Utils::WSDL.wsdl_sp(ambiente.to_s)[operacao.to_sym] # Sefaz São Paulo - (SP)
        end
      end
  
      # Sefaz Amazonas - (AM)
      def self.wsdl_am(ambiente)
        case ambiente
        when "1"
          {
            NfeInutilizacao:        "https://nfe.sefaz.am.gov.br/services2/services/NfeInutilizacao4?wsdl",
            NfeConsultaProtocolo:   "https://nfe.sefaz.am.gov.br/services2/services/NfeConsulta4?wsdl",
            NfeStatusServico:       "https://nfe.sefaz.am.gov.br/services2/services/NfeStatusServico4?wsdl",
            RecepcaoEvento:         "https://nfe.sefaz.am.gov.br/services2/services/RecepcaoEvento4?wsdl",
            NFeAutorizacao:         "https://nfe.sefaz.am.gov.br/services2/services/NfeAutorizacao4?wsdl",
            NFeRetAutorizacao:      "https://nfe.sefaz.am.gov.br/services2/services/NfeRetAutorizacao4?wsdl"
          }
        when "2"
          {
            NfeInutilizacao:        "https://homnfe.sefaz.am.gov.br/services2/services/NfeInutilizacao4?wsdl",
            NfeConsultaProtocolo:   "https://homnfe.sefaz.am.gov.br/services2/services/NfeConsulta4?wsdl",
            NfeStatusServico:       "https://homnfe.sefaz.am.gov.br/services2/services/NfeStatusServico4?wsdl",
            RecepcaoEvento:         "https://homnfe.sefaz.am.gov.br/services2/services/RecepcaoEvento4?wsdl",
            NFeAutorizacao:         "https://homnfe.sefaz.am.gov.br/services2/services/NfeAutorizacao4?wsdl",
            NFeRetAutorizacao:      "https://homnfe.sefaz.am.gov.br/services2/services/NfeRetAutorizacao4?wsdl"
          }
        end
      end
  
      # Sefaz Bahia - (BA)
      def self.wsdl_ba(ambiente)
        case ambiente
        when "1"
          {
            NfeInutilizacao:        "https://nfe.sefaz.ba.gov.br/webservices/NFeInutilizacao4/NFeInutilizacao4.asmx?wsdl",
            NfeConsultaProtocolo:   "https://nfe.sefaz.ba.gov.br/webservices/NFeConsultaProtocolo4/NFeConsultaProtocolo4.asmx?wsdl",
            NfeStatusServico:       "https://nfe.sefaz.ba.gov.br/webservices/NFeStatusServico4/NFeStatusServico4.asmx?wsdl",
            NfeConsultaCadastro:    "https://nfe.sefaz.ba.gov.br/webservices/CadConsultaCadastro4/CadConsultaCadastro4.asmx?wsdl",
            RecepcaoEvento:         "https://nfe.sefaz.ba.gov.br/webservices/NFeRecepcaoEvento4/NFeRecepcaoEvento4.asmx?wsdl",
            NFeAutorizacao:         "https://nfe.sefaz.ba.gov.br/webservices/NFeAutorizacao4/NFeAutorizacao4.asmx?wsdl",
            NFeRetAutorizacao:      "https://nfe.sefaz.ba.gov.br/webservices/NFeRetAutorizacao4/NFeRetAutorizacao4.asmx?wsdl"
          }
        when "2"
          {
            NfeInutilizacao:        "https://hnfe.sefaz.ba.gov.br/webservices/NFeInutilizacao4/NFeInutilizacao4.asmx?wsdl",
            NfeConsultaProtocolo:   "https://hnfe.sefaz.ba.gov.br/webservices/NFeConsultaProtocolo4/NFeConsultaProtocolo4.asmx?wsdl",
            NfeStatusServico:       "https://hnfe.sefaz.ba.gov.br/webservices/NFeStatusServico4/NFeStatusServico4.asmx?wsdl",
            NfeConsultaCadastro:    "https://hnfe.sefaz.ba.gov.br/webservices/CadConsultaCadastro4/CadConsultaCadastro4.asmx?wsdl",
            RecepcaoEvento:         "https://hnfe.sefaz.ba.gov.br/webservices/NFeRecepcaoEvento4/NFeRecepcaoEvento4.asmx?wsdl",
            NFeAutorizacao:         "https://hnfe.sefaz.ba.gov.br/webservices/NFeAutorizacao4/NFeAutorizacao4.asmx?wsdl",
            NFeRetAutorizacao:      "https://hnfe.sefaz.ba.gov.br/webservices/NFeRetAutorizacao4/NFeRetAutorizacao4.asmx?wsdl"
          }
        end
      end
  
      # Sefaz São Paulo - (SP)
      def self.wsdl_sp(ambiente)
        case ambiente
        when "1"
          {
            NfeInutilizacao:        "https://nfe.fazenda.sp.gov.br/ws/nfeinutilizacao4.asmx?wsdl",
            NfeConsultaProtocolo:   "https://nfe.fazenda.sp.gov.br/ws/nfeconsultaprotocolo4.asmx?wsdl",
            NfeStatusServico:       "https://nfe.fazenda.sp.gov.br/ws/nfestatusservico4.asmx?wsdl",
            NfeConsultaCadastro:    "https://nfe.fazenda.sp.gov.br/ws/cadconsultacadastro4.asmx?wsdl",
            RecepcaoEvento:         "https://nfe.fazenda.sp.gov.br/ws/nferecepcaoevento4.asmx?wsdl",
            NFeAutorizacao:         "https://nfe.fazenda.sp.gov.br/ws/nfeautorizacao4.asmx?wsdl",
            NFeRetAutorizacao:      "https://nfe.fazenda.sp.gov.br/ws/nferetautorizacao4.asmx?wsdl"
          }
        when "2"
          {
            NfeInutilizacao:        "https://homologacao.nfe.fazenda.sp.gov.br/ws/nfeinutilizacao4.asmx?wsdl",
            NfeConsultaProtocolo:   "https://homologacao.nfe.fazenda.sp.gov.br/ws/nfeconsultaprotocolo4.asmx?wsdl",
            NfeStatusServico:       "https://homologacao.nfe.fazenda.sp.gov.br/ws/nfestatusservico4.asmx?wsdl",
            NfeConsultaCadastro:    "https://homologacao.nfe.fazenda.sp.gov.br/ws/cadconsultacadastro4.asmx?wsdl",
            RecepcaoEvento:         "https://homologacao.nfe.fazenda.sp.gov.br/ws/nferecepcaoevento4.asmx?wsdl",
            NFeAutorizacao:         "https://homologacao.nfe.fazenda.sp.gov.br/ws/nfeautorizacao4.asmx?wsdl",
            NFeRetAutorizacao:      "https://homologacao.nfe.fazenda.sp.gov.br/ws/nferetautorizacao4.asmx?wsdl"
          }
        end
      end
  
    end
  end
end
