var hiddenBioListen = function(){

  $('.hidden-bio').hide();
  $(".mouseover-bio").hover(
     function(){
         $("#" + this.id + "-info").show();
     }, function(){
         $("#" + this.id + "-info").hide();
       });
};
