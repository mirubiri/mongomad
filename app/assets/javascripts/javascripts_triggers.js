$(window).load(function(){
  //slideOptionsPanel();
  ajaxLinksUrlChange();
  matchPrincipalContainersHeighs();
  expandRequestContainer();
  expandRightContainer();
  buttonsClickBackgroundChange();
  lastElementPosition();
});


$(window).bind('resize', function() {
  reloadPrincipalContainersHeighs();
  matchPrincipalContainersHeighs();
  expandRequestContainer();
  expandRightContainer();
  buttonsClickBackgroundChange();
  activateAlertButton(); 
});



