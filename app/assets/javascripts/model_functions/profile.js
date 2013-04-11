function addProfileCommentsSeparator(){
  if ( ($('#comment_list').height()) > ($('#data_list').height()) ) {
      $('#comment_list').css({'border-left': '1px solid rgb(220,220,220)'});
  }else{$('#data_list').css({'border-right': '1px solid rgb(220,220,220)'});}
}

function setProfileContainersHeights(){
  alturaPpalContainer = $('#ppal_container').height();
  alturaDisponible = alturaPpalContainer;
  alturaPerfil = (alturaDisponible * 40)/100;
  alturaComentarios = (alturaDisponible * 60)/100;

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
