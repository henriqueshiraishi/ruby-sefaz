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
    end

    module Hash
      def to_xml!
        Gyoku.xml(self, key_converter: :none)
      end

      def compress!
        self.to_xml!.compress!.to_hash!      
      end
    end

  end
end

String.class_eval { include SEFAZ::Refinement::String }
Hash.class_eval { include SEFAZ::Refinement::Hash }
