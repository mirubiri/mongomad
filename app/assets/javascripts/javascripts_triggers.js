$(window).load(function(){
  //slideOptionsPanel();
  ajaxLinksUrlChange();
  reloadPrincipalContainersHeighs();
  matchPrincipalContainersHeighs();
  expandRequestContainer();
  expandContainers();
  buttonsClickBackgroundChange();
  lastElementPosition();
});


$(window).bind('resize', function() {
  reloadPrincipalContainersHeighs();
  matchPrincipalContainersHeighs();
  expandRequestContainer();
  expandContainers();
  buttonsClickBackgroundChange();
  activateAlertButton();
});



