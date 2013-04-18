$(window).load(function(){
  //slideOptionsPanel();
  ajaxLinksUrlChange();
  expandContainers();
  reloadPrincipalContainersHeighs();
  matchPrincipalContainersHeighs();
  expandRequestContainer();
  buttonsClickBackgroundChange();
  lastElementPosition();
});


$(window).bind('resize', function() {
  expandContainers();
  reloadPrincipalContainersHeighs();
  matchPrincipalContainersHeighs();
  expandRequestContainer();
  buttonsClickBackgroundChange();
  activateAlertButton();
});



