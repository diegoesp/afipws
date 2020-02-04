module Afipws
  class WSMTXA
    WSDL = {
      development: 'https://fwshomo.afip.gov.ar/wsmtxca/services/MTXCAService?wsdl',
      production: 'https://serviciosjava.afip.gob.ar/wsmtxca/services/MTXCAService?wsdl',
      test: Root + '/spec/fixtures/wsmtxca/wsmtxca.wsdl'
    }.freeze

    include TypeConversions

    attr_reader :wsaa, :cuit

    def initialize options = {}
      @cuit = options[:cuit]
      @wsaa = WSAA.new options.merge(service: 'wsmtxca')
      @client = Client.new Hash(options[:savon]).reverse_merge(wsdl: WSDL[@wsaa.env], convert_request_keys_to: :lower_camelcase, log: true, log_level: :debug, logger: Logger.new('log/savon.log'), pretty_print_xml: true)
    end

    def dummy
      request :fe_dummy
    end

    def autorizar_comprobante comprobante
      mensaje = 
      {
        "authRequest" => auth,
        "comprobanteCAERequest" => comprobante
      }
      
      mensaje = r2x(mensaje,
        fecha_emision: :date_hyphenated,
        fecha_vencimiento: :date_hyphenated, 
        fecha_servicio_desde: :date_hyphenated, 
        fecha_servicio_hasta: :date_hyphenated,
        fecha_vencimiento_pago: :date_hyphenated,
        fecha_hora_gen: :datetime)

      response = request :autorizar_comprobante, mensaje

      x2r response, fecha_emision: :date_hyphenated, 
        fecha_vencimiento: :date_hyphenated,
        fecha_servicio_desde: :date_hyphenated, 
        fecha_servicio_hasta: :date_hyphenated,
        fecha_vencimiento_pago: :date_hyphenated,
        fecha_hora_gen: :datetime
    end

    def consultar_ultimo_comprobante_autorizado opciones
      raise "Debe suplir :codigo_tipo_comprobante" if opciones[:codigo_tipo_comprobante].blank?
      raise "Debe suplir :numero_punto_venta" if opciones[:numero_punto_venta].blank?

      mensaje = 
      {
        "authRequest" => auth,
        "consultaUltimoComprobanteAutorizadoRequest" => opciones
      }

      response = request :consultar_ultimo_comprobante_autorizado, mensaje
      response[:numero_comprobante].to_i
    end

    def consultar_comprobante opciones
      raise "Debe suplir :codigo_tipo_comprobante" if opciones[:codigo_tipo_comprobante].blank?
      raise "Debe suplir :numero_punto_venta" if opciones[:numero_punto_venta].blank?
      raise "Debe suplir :numero_comprobante" if opciones[:numero_comprobante].blank?

      mensaje = 
      {
        "authRequest" => auth,
        "consultaComprobanteRequest" => opciones
      }
      
      request :consultar_comprobante, mensaje

      # x2r response
    end

    private

    def auth
      auth = @wsaa.auth
      auth["token"] = auth.delete(:token)
      auth["sign"] = auth.delete(:sign)
      auth["cuitRepresentada"] = @cuit
      auth
    end

    def request action, body = nil
      response = @client.request(action, body).to_hash[:"#{action.to_s}_response"]
      if response[:resultado] == "R"
        raise WSError, response[:array_errores]
      else
        response
      end
    end

  end
end