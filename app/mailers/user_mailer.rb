class UserMailer < ApplicationMailer
  default :from => "romp.mailer@gmail.com"

def like_notification(user, activity)
    @user = user
    @activity = activity
    mail(to: @user.email, subject: "Someone Liked #{@activity.name} on Romp!" )
 end
end
