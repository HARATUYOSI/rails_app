require 'test_helper'

class HashtagTest < ActiveSupport::TestCase
  def setup
    @hashtag = Hashtag.new(name: 'test')
  end

  test "同じデータが重複しないか" do
    hashtag_dup = @hashtag.dup
    @hashtag.save
    assert_not hashtag_dup.valid?
  end
end
