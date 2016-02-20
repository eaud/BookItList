require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'fetch approved guest activities hosted by a specified user' do
    derek = User.find_or_create_by!(email: "derek@flatiron.com")
    kaylee = User.find_or_create_by!(email: "kaylee@flatiron.com")
    jappleba = User.find_or_create_by!(email: "jappleba@flatiron.com")

    rando =  User.find_or_create_by!(email: "rando@gmail.com")

    beyonce_bash = derek.activities.create!(name: 'Beyonce Bash',
                                            details: "Celebrate Beyonce's greatness.",
                                            guest_max: 10,
                                            guest_min: 1,
                                            cost: 0.00,
                                            datetime: Time.zone.now+24.hours)

    beyonce_bash.activity_guests.create!(guest: kaylee,   aasm_state: 'approved')
    beyonce_bash.activity_guests.create!(guest: jappleba, aasm_state: 'approved')
    beyonce_bash.activity_guests.create!(guest: rando,    aasm_state: 'denied')

    assert_equal kaylee.approved_guest_activities_hosted_by(derek).to_a, [beyonce_bash]
    assert_equal jappleba.approved_guest_activities_hosted_by(derek).to_a, [beyonce_bash]
    assert_equal rando.approved_guest_activities_hosted_by(derek).to_a, []
  end
end
