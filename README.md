# Afipws ex

Ruby client para los web services de la AFIP. Fork de https://github.com/eeng/afipws. Extendido para agregar
el servicio wsmtxca. Algun dia, cuando tenga tiempo, haré un pull request para meter la funcionalidad
en el proyecto madre.

## Servicios Disponibles

* wsaa (WSAA)
* wsfe (WSFEv1)
* ws_sr_constancia_inscripcion (WSConstanciaInscripcion)
* ws_sr_padron_a100 (PersonaServiceA100)
* ws_sr_padron_a4 (PersonaServiceA4)
* wconsdeclaracion (WConsDeclaracion)
* wsmtxca (WSMTXCA)

## Uso

1) Generar certificados siguiendo las [instrucciones](http://www.afip.gov.ar/ws/WSAA/cert-req-howto.txt).
2) Instalar la gema

```ruby
gem install afipws
```

3) Usar el web service:

```ruby
require 'afipws'

wsmtxa = Afipws::WSMTXA.new(
	env: :development, 
	cuit: "30339128591",
	key: File.read(...),
	cert: File.read(...)
)

puts wsmtxa.consultar_ultimo_comprobante_autorizado { codigo_tipo_comprobante: 1, numero_punto_venta: "003" }
```

Ver specs para más ejemplos.