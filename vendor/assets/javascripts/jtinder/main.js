/**
 * jTinder initialization
 */
var jTinderSwipeEffect = function(){
    $("#tinderslide").jTinder({
  	// dislike callback
      onDislike: jVoteNo,
  	// like callback
      onLike: jVoteYes,
  	animationRevertSpeed: 200,
  	animationSpeed: 400,
  	threshold: 1,
  	likeSelector: '.like',
  	dislikeSelector: '.dislike'
  });
};

var jVoteYes = function(event){
  console.log("thumbs up!");
  $.ajax({
    url: "/like/" + event[0].id,
    method: "POST",
    datatype: 'script'
  });
};

var jVoteNo = function(event){
  console.log("thumbs down!");
  $.ajax({
    url: "/dislike/" + event[0].id,
    method: "POST",
    datatype: 'script'
  });
};



/**
 * Set button action to trigger jTinder like & dislike.
 */
$('.actions .like, .actions .dislike').click(function(e){
	e.preventDefault();
	$("#tinderslide").jTinder($(this).attr('class'));
});
