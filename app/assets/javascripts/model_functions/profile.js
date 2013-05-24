function addProfileCommentsSeparator(){
  //alert("addProfileCommentsSeparator funcionando");

  if ( ($('#comment_list').height()) > ($('#data_list').height()) ) {
      $('#comment_list').css({'border-left': '1px solid rgb(220,220,220)'});
  }else{$('#data_list').css({'border-right': '1px solid rgb(220,220,220)'});}
}

function setProfileContainersHeights(){
  //salert("setProfileContainersHeights funcionando");

  var alturaContentSide = $('#content-side').height();
  var navBarHeight = $('#navigation_bar').height();
  var alturaDisponible = alturaContentSide - navBarHeight -10; // margen entre barra y contenido
  var alturaPerfil = (alturaDisponible * 38)/100;
  var alturaComentarios = (alturaDisponible * 57)/100;

  $('.person_info').css({'height': alturaPerfil  + 'px'});
  $('.person_info,.statistics').equalHeightColumns();
  $('.comments_recieved').css({'height': alturaComentarios  + 'px'});
}

function profileImageSelection(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $('#profile_image_container').attr('src', e.target.result);
    };
    reader.readAsDataURL(input.files[0]);
  }
}
