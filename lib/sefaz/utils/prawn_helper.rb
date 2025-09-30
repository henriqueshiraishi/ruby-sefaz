# frozen_string_literal: true

module SEFAZ
  module Utils
    # Módulo com recursos adicionais para os templates baseados na Prawn
    module PrawnHelper

      Prawn::Fonts::AFM.hide_m17n_warning = true

      def dash(doc, gap:, space:, line_width:, x1:, x2:, y:)
        doc.dash(gap, space: space)
        doc.line_width line_width
        doc.stroke_horizontal_line x1, x2, at: y
        doc.move_down 2
      end

      def barcode_128c(doc, value:, x:, y:, xdim: 1, height: 20, margin: 0, unbleed: 0, color: '000000')
        barcode = Barby::Code128C.new(value)
        outputter = Barby::PrawnOutputter.new(barcode)
        outputter.x = x
        outputter.y = (y - height)
        outputter.xdim = xdim
        outputter.height = height
        outputter.margin = margin
        outputter.unbleed = unbleed
        outputter.color = color

        doc.move_down height
        outputter.annotate_pdf doc
      end

      def qrcode(doc, value:, x:, y:, xdim: 1, margin: 0, unbleed: 0, color: '000000')
        qrcode = Barby::QrCode.new(value)
        outputter = Barby::PrawnOutputter.new(qrcode)
        height = (outputter.boolean_groups.length * xdim)
        outputter.x = x
        outputter.y = (y - height)
        outputter.xdim = xdim
        outputter.margin = margin
        outputter.unbleed = unbleed
        outputter.color = color

        doc.move_down height
        outputter.annotate_pdf doc
      end

    end
  end
end
