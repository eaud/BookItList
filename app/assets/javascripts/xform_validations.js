function FormValidations(){

}
jQuery.validator.addMethod("greaterThanMin", function(value, element) {
    return this.optional(element) || (parseFloat(value) >= $('#activity_guest_min').val());
}, "* Amount must be greater than min guests");


FormValidations.prototype.activityForm = function () {
  $("#activityForm").validate({
    // // errorPlacement: function(error,element) {
    // //   if (element.attr("name") == "activity[tag_ids][]"){
    // //     error.insertAfter($(".tag-checkboxes"));
    // //   }else{
    // //     error.insertAfter(element);
    // //   }
    // },
    rules: {
      "activity[name]": {
        required: true,
        minlength: 2,
        maxlength: 60
      },
      "activity[guest_min]": {
        required: true,
        digits: true
      },
      "activity[guest_max]": {
        required: true,
        digits: true,
        greaterThanMin: true
      },
      "activity[details]": {
        required: true,
        minlength: 10
      },
      "activity[cost]": {
        required: true,
        digits: true
      },
      "activity[image_url]": {
        required: true,
      },
      "activity[tag_ids][]": {
        required: true,
      },

    },
    messages: {
      "activity[name]": {
        required: "Your activity must have a name, silly!",
        minlength: "Type more... size matters.",
        maxlength: "..But it doesn't matter that much"
      },
      "activity[guest_min]": {
        required: "Don't you want someone to come?",
        digits: "It's gotta be a number"
      },
      "activity[guest_max]": {
        required: "Don't let it get too crowded",
        digits: "It's gotta be a number",
        greaterThanMin: "Must be greater than or equal to minimum guest number"
      },
      "activity[details]": {
        required: "Seriously let us know what's up",
        minlength: "Give us an actual description"
      },
      "activity[cost]": {
        required: "tell us bout the $$$",
        digits: "provide a guess at the cost as a whole number, no $"
      },
      "activity[image_url]": {
        required: "It has to be pretty!"
      },
      "activity[tag_ids][]": {
        required: "Include at least one tag so people can find your activity!"
      },
    }
  });

};

FormValidations.prototype.userForm = function () {
  $("#userForm").validate({
    errorPlacement: function(error,element) {
      if (element.attr("name") == "user[tag_ids][]"){
        error.insertAfter($(".tag-checkboxes"));
      }else{
        error.insertAfter(element);
      }
    },
    rules: {
      "user[name]": {
        required: true,
        minlength: 2,
        maxlength: 60
      },
      "user[bio]": {
        required: true,
        minlength: 2,
        maxlength: 140
      },
      "user[email]": {
        required: true,
      },
      "user[image_url]": {
        required: true,
      },
      "user[tag_ids][]": {
        required: true,
      },

    },
    messages: {
      "user[name]": {
        required: "What's your name!",
        minlength: "Type more... size matters.",
        maxlength: "..check yourself nobody care that much"
      },
      "user[bio]": {
        required: "TELL US ABOUT YOU",
        minlength: "Type more... size matters.",
        maxlength: "..check yourself nobody care that much"
      },
      "user[email]": {
        required: "how are people supposed to contact you when you're matched?",
      },
      "user[image_url]": {
        required: "It has to be pretty!"
      },
      "user[tag_ids][]": {
        required: "Check at least one thing to make you more scoreable"
      },
    }
  });
};

FormValidations.prototype.messageForm = function() {
  $('#new_message').validate({
    rules: {
      "message[content]": "required"
    },
    messages: {
      "message[content]": "Hey, leave us a message!"
    }
  });
};
