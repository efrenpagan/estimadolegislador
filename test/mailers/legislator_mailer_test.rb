require 'test_helper'

class LegislatorMailerTest < ActionMailer::TestCase
  test "send_legislator_email" do
    mail = LegislatorMailer.send_legislator_email
    assert_equal "Send legislator email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
