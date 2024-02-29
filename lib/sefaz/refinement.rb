# frozen_string_literal: true

module SEFAZ
  # Módulo base de refinamento da biblioteca
  module Refinement

    module String
      def to_hash!
        Nori.new(convert_tags_to: lambda { |key| key.to_sym }).parse(self)
      end

      def compress!
        doc = Nokogiri::XML::Document.parse(self, nil, "utf-8", Nokogiri::XML::ParseOptions::NOBLANKS)
        doc.search('*').each { |node| node.remove if node.content.strip.blank? }
        doc.canonicalize
      end

      def mask!(mask)
        index = -1
        mask.gsub('#') { self[index += 1] }
      end

      def to_number(options={})
        return self.gsub(/,/, '.').to_f if self.numeric?
        nil
      end

      def numeric?
        self =~ /^(|-)?[0-9]+((\.|,)[0-9]+)?$/ ? true : false
      end

      def to_currency(options = {})
        return self.to_number.to_currency(options) if self.numeric?
        nil
      end
    end

    module Hash
      def to_xml!
        Gyoku.xml(self, key_converter: :none)
      end

      def compress!
        self.to_xml!.compress!.to_hash!      
      end
    end

    module Currency
      def to_currency(options = {})
        number    = self
        default   = Configuration.default.currency_format
        options   = default.merge(options)
        precision = options[:precision] || default[:precision]
        unit      = options[:unit] || default[:unit]
        position  = options[:position] || default[:position]
        separator = precision > 0 ? options[:separator] || default[:separator] : ""
        delimiter = options[:delimiter] || default[:delimiter]
  
        begin
          parts = number.with_precision(precision).split('.')
          number = parts[0].to_i.with_delimiter(delimiter) + separator + parts[1].to_s
          position == "before" ? unit + number : number + unit
        rescue
          number
        end
      end

      def with_delimiter(delimiter = ",", separator = ".")
        number = self
        begin
          parts = number.to_s.split(separator)
          parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{delimiter}")
          parts.join separator
        rescue
          self
        end
      end

      def with_precision(precision = 3)
        number = self
        "%01.#{precision}f" % number
      end
    end

  end
end

String.class_eval { include SEFAZ::Refinement::String }
Hash.class_eval { include SEFAZ::Refinement::Hash }
Integer.class_eval { include SEFAZ::Refinement::Currency }
Float.class_eval { include SEFAZ::Refinement::Currency }
