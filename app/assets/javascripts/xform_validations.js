function FormValidations(){

}
jQuery.validator.addMethod("greaterThanMin", function(value, element) {
    return this.optional(element) || (parseFloat(value) >= $('#activity_guest_min').val());
}, "* Amount must be greater than min guests");


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
        number: true
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
        minlength: "One letter isn't a name...",
        maxlength: "Keep it short & sweet."
      },
      "activity[guest_min]": {
        required: "Let us know how many people can come!",
        digits: "It's gotta be a number"
      },
      "activity[guest_max]": {
        required: "Let us know how many people can come!",
        digits: "It's gotta be a number",
        greaterThanMin: "Must be greater than or equal to minimum guest number"
      },
      "activity[details]": {
        required: "Let us know the deets!",
        minlength: "Be at least 10 characters worth of descriptive, please."
      },
      "activity[cost]": {
        required: "Tell us 'bout the $$$'",
        digits: "Provide a guess at the cost, just digits no $$$"
      },
      "activity[image_url]": {
        required: "Go snag an image url!"
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
        maxlength: 300
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
        required: "What's your name?",
        minlength: "At least 2 letters",
        maxlength: "Shorten it up a bit"
      },
      "user[bio]": {
        required: "Tell us all about you!!!",
        minlength: "Give us a little bit more to go on ;)",
        maxlength: "Keep it short & sweet"
      },
      "user[email]": {
        required: "Please provide an email so we can stay in touch!",
      },
      "user[image_url]": {
        required: "Great place for your best selfie (use a url)"
      },
      "user[tag_ids][]": {
        required: "Check at least one thing so we can give you better matches!"
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
