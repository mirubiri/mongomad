$(window).load(function(){
  //slideOptionsPanel();
  ajaxLinksUrlChange();
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
  expandContainers();// Tengo que llevarmelo a la ejecucion de los index de cada modelo
  buttonsClickBackgroundChange();
  activateAlertButton();
});



