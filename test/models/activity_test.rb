require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  test 'correctly find activities user hosts or doesnt host' do
    derek = User.find_or_create_by!(email: "derek@flatiron.com")
    rando = User.find_or_create_by!(email: "rando@gmail.com")

    derek_activity = derek.activities.create!(name: 'Beyonce Bash',
                                              details: "Celebrate Beyonce's greatness.",
                                              guest_max: 10,
                                              guest_min: 1,
                                              cost: 0.00,
                                              datetime: Time.zone.now+24.hours)
    rando_activity = rando.activities.create!(name: 'Protest Beyonce halftime show',
                                              details: "We don't have anything better to do.",
                                              guest_max: 10,
                                              guest_min: 1,
                                              cost: 0.00,
                                              datetime: Time.zone.now+24.hours)

    assert_equal Activity.not_hosted_by(derek).to_a, [rando_activity]
    assert_equal Activity.hosted_by(derek).to_a, [derek_activity]
  end

  test 'correctly find activities that are open or closed' do
    derek = User.find_or_create_by!(email: "derek@flatiron.com")
    rando = User.find_or_create_by!(email: "rando@gmail.com")

    open_activity = derek.activities.create!(name: 'Beyonce Bash',
                                              details: "Celebrate Beyonce's greatness.",
                                              guest_max: 10,
                                              guest_min: 1,
                                              cost: 0.00,
                                              datetime: Time.zone.now+24.hours)
    closed_activity = rando.activities.create!(name: 'Protest Beyonce halftime show',
                                              details: "We don't have anything better to do.",
                                              guest_max: 10,
                                              guest_min: 1,
                                              cost: 0.00,
                                              datetime: Time.zone.now+24.hours)

    closed_activity.close
    closed_activity.save!

    assert_equal Activity.open.to_a, [open_activity]
    assert_equal Activity.closed.to_a, [closed_activity]
  end
end
