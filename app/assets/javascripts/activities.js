$(document).ready(function(){
  $(".dropdown-toggle").dropdown();
  addThumbsUpListener();
  addThumbsDownListener();
  hiddenBioListen();
  var formValidator = new FormValidations();
    formValidator.activityForm();
    formValidator.userForm();
});


var addThumbsUpListener = function(){
  $("span.glyphicon-thumbs-up").on("click", function(event){
    console.log("thumbs up!");
    var activity_container = this.parentElement.parentElement.parentElement;
    var activity_id_this_is_janky = this.parentElement.parentElement.parentElement.id;
    $.ajax({
      url: "/like/" + activity_id_this_is_janky,
      method: "POST",
      datatype: 'script'
    });
    activity_container.remove();
  });
};

var addThumbsDownListener = function(){
  $("span.glyphicon-thumbs-down").on("click", function(event){
    console.log("thumbs down!");
    var activity_container = this.parentElement.parentElement.parentElement;
    var activity_id_this_is_janky = this.parentElement.parentElement.parentElement.id;
    $.ajax({
      url: "/dislike/" + activity_id_this_is_janky,
      method: "POST",
      datatype: 'script'
    });
    activity_container.remove();
  });
};
