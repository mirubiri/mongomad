// Una funcion que cree para los paneles desplegables de opciones
function slideOptionsPanel(){
  $(".triangle > #options_button").live('click',function(e){
    $(this).parent().parent().parent().find('#options').slideToggle('fast');
    e.preventDefault();
  });
}