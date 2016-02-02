// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require turbolinks
//= require_tree .

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

var hiddenBioListen = function(){

  $('.hidden-bio').hide();
  $(".mouseover-bio").hover(
     function(){
         $("#" + this.id + "-info").show();
     }, function(){
         $("#" + this.id + "-info").hide();
       });
};

jQuery.validator.addMethod("greaterThanMin", function(value, element) {
    return this.optional(element) || (parseFloat(value) >= $('#activity_guest_min').val());
}, "* Amount must be greater than min guests");
