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
});


var addThumbsUpListener = function(){
  $("span.glyphicon-thumbs-up").on("click", function(event){
    console.log("thumbs up!");
    $("activityForm").validate({
      rules: {
        thisname: "required"
      },
      messages: {
        thisname: "YOU A HO"
      }
    });
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

function FormValidations(){

}

FormValidations.prototype.activityForm = function () {
  $("#activityForm").validate({
    errorPlacement: function(error,element) {
      if (element.attr("name") == "activity[tag_ids][]"){
        error.insertAfter($(".tag-checkboxes"));
      }else{
        error.insertAfter(element);
      }
    },
    rules: {
      activity_name: {
        required: true,
        minlength: 2,
        maxlength: 60
      },
      activity_guest_min: {
        required: true,
        digits: true
      },
      activity_guest_max: {
        required: true,
        digits: true
      },
      activity_details: {
        required: true,
        minlength: 10
      },
      activity_cost: {
        required: true,
        digits: true
      },
      activity_image_url: {
        required: true,
      },
      "activity[tag_ids][]": {
        required: true,
      },

    },
    messages: {
      activity_name: {
        required: "Your activity must have a name, silly!",
        minlength: "Type more... size matters.",
        maxlength: "..But it doesn't matter that much"
      },
      activity_guest_min: {
        required: "Don't you want someone to come?",
        digits: "It's gotta be a number"
      },
      activity_guest_max: {
        required: "Don't let it get too crowded",
        digits: "It's gotta be a number"
      },
      activity_details: {
        required: "Seriously let us know what's up",
        minlength: "Give us an actual description"
      },
      activity_cost: {
        required: "tell us bout the $$$",
        digits: "provide a guess at the cost as a whole number, no $"
      },
      activity_image_url: {
        required: "It has to be pretty!"
      },
      "activity[tag_ids][]": {
        required: "Include at least one tag so people can find your activity!"
      },
    }
  });

};
