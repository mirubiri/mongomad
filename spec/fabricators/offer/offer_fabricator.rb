=begin
 
  -Relaciones descendentes (Ex. composer,receiver,money)
    Como norma general hay que fabricar solo las relaciones descendentes 
    imprescindibles en la definicíon de los campos de la fabrica utilizando
    Fabricate.build()
  
  -Relaciones ascendentes(Ex. No hay en este caso)
    Como norma general hay que darles valor nulo

  -Campos (Ex. initial_message)
    Se les da valor en la definicion de los campos de la fabrica. Puede
    ser a partir del valor de un campo definido previamente.

 Asi seria la fabrica para offer en un caso normal.

Fabricator(:offer) do
  composer         { Fabricate.build(:offer_composer,user_id:Fabricate(:user_with_things)) }
  receiver         { Fabricate.build(:offer_receiver,user_id:Fabricate(:user_with_things)) }
  money            nil
  initial_message 'message'
end

El problema de esta solucion es que una Offer requiere estar presente como enviada
o recibida en los usuarios que crea ella misma, asi que se necesita hacer uso de
after_build, como se detalla a continuacion
=end

# Lo siguiente es lo que hay que utilizar a la hora de definir las fabricas para 
# Negotiation y Deal.

# ¿Listo para chinofarmear?

Fabricator(:offer) do 
  composer        nil
  receiver        nil
  money           nil

  initial_message 'message'

  after_build do |offer|

    user_composer = Fabricate(:user_with_things)
    
    # user: es transient en :offer_composer, lo que me permite
    # extraer en la fabrica de offer_composer los datos requeridos del usuario
    offer.composer = Fabricate.build(:offer_composer,user:user_composer) 
    
    
    # En caso de que fabricaramos los usuarios en los atributos,
    # en after_build solo podriamos acceder a ellos 
    # utilizando el user_id que guardan composer y receiver de la siguiente 
    # manera:
    #
    # composer=User.find(offer.composer.user_id)
    # receiver=User.find(offer.receiver.user_ud)
    #
    # El problema de esto es que si utilizaramos Fabricate.build(:offer)
    # para fabricar la oferta, obtendriamos una excepcion, ya que el usuario 
    # no se encuentra guardado en la base de datos donde lo busca User.find, con lo que
    # no podriamos anadir la oferta a los respectivos usuarios dentro de
    # after_build ya que no podriamos acceder a ellos de ninguna manera.
    # En cambio al crearlos en after_build no nos hace falta recuperarlos
    # con un User.find ya que disponemos de ellos en las variables, lo que
    # a su vez permite el uso de offer=Fabricate.build(:offer) y el posterior
    # offer.save, ademas de poder incluir en ellos la oferta sin problemas.
    # Este es el motivo por lo que en este caso no fabricamos los usuarios en
    # los atributos
    user_composer.sent_offers << offer


  	user_receiver = Fabricate(:user_with_things)
    offer.receiver = Fabricate.build(:offer_receiver,user:user_receiver)
    user_receiver.received_offers << offer

  end
end

Fabricator(:offer_with_money, from: :offer) do
    money { Fabricate.build(:offer_money,user_id:offer.composer.user_id) }
end

