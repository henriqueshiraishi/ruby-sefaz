# frozen_string_literal: true

module SEFAZ
  # Classe base para parametrização da biblioteca
  class Configuration

    # Configuração da formatação de valores monetários
    attr_accessor :currency_format

    # CF-e (Cupom Fiscal Eletrônico)
    attr_accessor :cfe_qr_code_aplicativo
    attr_accessor :cfe_cMP_cod_desc

    # 55mm
    attr_accessor :cfe_page_width_55mm
    attr_accessor :cfe_margin_55mm

    # 80mm
    attr_accessor :cfe_page_width_80mm
    attr_accessor :cfe_margin_80mm

    def initialize
      @currency_format = { delimiter: ".", separator: ",", unit: "", precision: 2, position: "before" }
      @cfe_qr_code_aplicativo = "De olho na nota"
      @cfe_cMP_cod_desc = {
        "01" => "Dinheiro",
        "02" => "Cheque",
        "03" => "Cartão de Crédito",
        "04" => "Cartão de Débito",
        "05" => "Crédito Loja",
        "10" => "Vale Alimentação",
        "11" => "Vale Refeição",
        "12" => "Vale Presente",
        "13" => "Vale Combustível",
        "15" => "Boleto Bancário",
        "16" => "Depósito Bancário",
        "17" => "Pagamento Instantâneo (PIX)",
        "18" => "Transferência bancária, Carteira Digital",
        "19" => "Programa de fidelidade, Cashback, Crédito Virtual",
        "90" => "Sem pagamento",
        "99" => "Outros"
      }

      # 50mm
      @cfe_page_width_55mm = 55.mm
      @cfe_margin_55mm = 5.mm

      # 80mm
      @cfe_page_width_80mm = 80.mm
      @cfe_margin_80mm = 5.mm
    end

    def self.default
      @default ||= Configuration.new
    end

  end
end
