require 'test_helper'

class PoliticianMailerTest < ActionMailer::TestCase
  test "send_politician_email" do
    mail = PoliticianMailer.send_politician_email
    assert_equal "Send politician email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
