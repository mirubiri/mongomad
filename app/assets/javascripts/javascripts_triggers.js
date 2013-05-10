$(window).load(function(){
  //slideOptionsPanel();
  ajaxLinksUrlChange();
  expandContainers();
  reloadPrincipalContainersHeighs();
  matchPrincipalContainersHeighs();
  expandRequestContainer();
  buttonsClickBackgroundChange();
  lastElementPosition();
  editProposalScript();
  activateNegotiationButtons();
  maximizeConversationWidth();
  editOfferScript();
});


$(window).bind('resize', function() {
  expandContainers();
  reloadPrincipalContainersHeighs();
  matchPrincipalContainersHeighs();
  expandRequestContainer();
  buttonsClickBackgroundChange();
  activateAlertButton();
});



