$(window).load(function(){
  alert("se dispara el load");
  //slideOptionsPanel();
  reloadPrincipalContainersHeighs();
  expandContainers();
  matchPrincipalContainersHeighs();
  expandRequestContainer();    
  activateNegotiationButtons();
  maximizeConversationWidth();
  setProfileContainersHeights();
  addProfileCommentsSeparator();
});


$(window).bind('resize', function() {
  alert("se dispara el resize");
  reloadPrincipalContainersHeighs();
  expandContainers();
  matchPrincipalContainersHeighs();
  expandRequestContainer();    
  activateNegotiationButtons();
  maximizeConversationWidth();
  setProfileContainersHeights();
  addProfileCommentsSeparator();
});