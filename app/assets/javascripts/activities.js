$(window).load(function(){
  $(".dropdown-toggle").dropdown();
  addThumbsUpListener();
  addThumbsDownListener();
  hiddenBioListen();
  jTinderSwipeEffect();
  var formValidator = new FormValidations();
    formValidator.activityForm();
    formValidator.userForm();
    FormValidations.prototype.messageForm();
});


var addThumbsUpListener = function(){
  $("span.glyphicon-thumbs-up").on("click", voteYes);
};

var voteYes = function(event){
  console.log("thumbs up!");
  var activity_container = this.parentElement.parentElement.parentElement;
  var activity_id_this_is_janky = this.parentElement.parentElement.parentElement.id;
  $.ajax({
    url: "/like/" + activity_id_this_is_janky,
    method: "POST",
    datatype: 'script'
  });
  activity_container.remove();
};

var addThumbsDownListener = function(){
  $("span.glyphicon-thumbs-down").on("click", voteNo);
};

var voteNo = function(event){
  console.log("thumbs down!");
  var activity_container = this.parentElement.parentElement.parentElement;
  var activity_id_this_is_janky = this.parentElement.parentElement.parentElement.id;
  $.ajax({
    url: "/dislike/" + activity_id_this_is_janky,
    method: "POST",
    datatype: 'script'
  });
  activity_container.remove();
};
