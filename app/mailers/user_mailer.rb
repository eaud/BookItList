class UserMailer < ApplicationMailer
  default :from => "romp.mailer@gmail.com"

  def like_notification(user, activity)
      @user = user
      @activity = activity
      mail(to: @user.email, subject: "Someone Liked #{@activity.name} on Romp!" )
   end

  def approved_notification(user, activity)
    @user = user
    @activity = activity
    mail(to: @user.email, subject: "You're Invited to #{@activity.name} on Romp!" )
  end

end
