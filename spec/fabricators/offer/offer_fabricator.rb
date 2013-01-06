=begin
 
  -Relaciones descendentes (composer,receiver,money)
    Como norma general hay que fabricar solo las relaciones descendentes 
    imprescindibles en la definicíon de los campos de la fabrica
  
  -Relaciones ascendentes(No hay en este ejemplo)
    Como norma general hay que darles valor nulo

  -Campos (initial_message)
    Se les da valor en la definicion de los campos de la fabrica. Puede
    ser a partir del valor de un campo definido previamente.

 Asi seria la fabrica para offer en un caso normal.

Fabricator(:offer) do
  composer         { Fabricate(:offer_composer,user_id:Fabricate(:user_with_things)) }
  receiver         { Fabricate(:offer_receiver,user_id:Fabricate(:user_with_things)) }
  money            nil
  initial_message 'message'
end

El problema de esta solucion es que una Offer requiere estar presente como enviada
o recibida en los usuarios que crea ella misma, asi que se necesita hacer uso de
after_build, como se detalla a continuacion
=end

Fabricator(:offer) do 
  composer        nil
  receiver        nil
  money           nil

  initial_message 'message'

  after_build do |offer|

    user_composer = Fabricate(:user_with_things)
    
    # user es transient en :offer_composer, lo que me permite
    # extraer en :offer_composer los datos requeridos del usuario
    offer.composer = Fabricate.build(:offer_composer,user:user_composer) 
    
    
    # En caso de que la fabrica estuviera definida de la forma normal
    # solo podriamos acceder a los usuarios creados en after_build 
    # utilizando el user_id que guardan composer y receiver de la siguiente 
    # manera
    #
    # composer=User.find(offer.composer.user_id)
    # receiver=User.find(offer.receiver.user_ud)
    #
    # El problema de esto es que si utilizamos Fabricate.build(:offer)
    # para fabricar la oferta, obtendriamos una excepcion, ua que el usuario 
    # no se encuentra guardado en la base de datos, esto quiere decir que
    # no podriamos anadir la oferta a los respectivos usuarios dentro de
    # after_build ya que no podriamos acceder a ellos de ninguna manera.
    # En cambio al crearlos en after_build no nos hace falta recuperarlos
    # con un User.find ya que disponemos de ellos en las variables, lo que
    # a su vez permite el uso de offer=Fabricate.build(:offer) y el posterior
    # offer.save, ademas de poder incluir en ellos la oferta sin problemas.
    user_composer.sent_offers << offer


  	user_receiver = Fabricate(:user_with_things)
    offer.receiver = Fabricate.build(:offer_receiver,user:user_receiver)
    user_receiver.received_offers << offer

  end
end

Fabricator(:offer_with_money, from: :offer) do
  after_build do |offer|
    offer.money=Fabricate.build(:offer_money,user_id:offer.composer.user_id)
  end
end

