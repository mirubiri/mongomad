require 'Hola'
module Hola::Prueba
  class Composer
    include ActiveResource::Concern
    include do
      embedded_in :cadc
    end

    include composer_code
    attr_accessor :hola
  end
end
module Hola::Prueba
  class Receiver
    attr_accessor :adios
  end
end
require 'Hola'