$(window).load(function(){
  $(".dropdown-toggle").dropdown();
  jTinderSwipeEffect();
  var formValidator = new FormValidations();
    formValidator.activityForm();
    formValidator.userForm();
    FormValidations.prototype.messageForm();
});

var linkGiphys = function(){
  $(".giphys").on("click", "div.activity-image.container", function(event){
    var url = this.style.backgroundImage.split('"')[1];
    this.classList.add("selected");
    var sibs = $(this).siblings();
    for (i = 0; i < sibs.length; i++) {
        sibs[i].classList.remove("selected");
    }

    $("#activity_image_url").val(url);
  });
};
//
// var addThumbsUpListener = function(){
//   $('.stack-randomrot').on("click", "span.glyphicon-thumbs-up", function(event){
//     console.log("thumbs up!");
//     var activity_container = this.parentElement.parentElement.parentElement;
//     var activity_id_this_is_janky = this.parentElement.parentElement.parentElement.id;
//     $.ajax({
//       url: "/like/" + activity_id_this_is_janky,
//       method: "POST",
//       datatype: 'script'
//     });
//     activity_container.remove();
//   });
// };
//
// var addThumbsDownListener = function(){
//   $('.stack-randomrot').on("click", "span.glyphicon-thumbs-down", function(event){
//     console.log("thumbs down!");
//     var activity_container = this.parentElement.parentElement.parentElement;
//     var activity_id_this_is_janky = this.parentElement.parentElement.parentElement.id;
//     $.ajax({
//       url: "/dislike/" + activity_id_this_is_janky,
//       method: "POST",
//       datatype: 'script'
//     });
//     activity_container.remove();
//   });
// };
