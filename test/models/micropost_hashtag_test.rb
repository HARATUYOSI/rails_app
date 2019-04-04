require 'test_helper'

class MicropostHashtagTest < ActiveSupport::TestCase
  def setup
    @micropost_hashtag = MicropostHashtag.new(micropost_id: microposts(:orange).id, hashtag_id: hashtags(:one).id)
  end

  test "オブジェクトの有効性" do
    assert @micropost_hashtag.valid?
  end

  test 'マイクロポストIDの必要性' do
    @micropost_hashtag.micropost_id = nil
    assert_not @micropost_hashtag.valid?
  end

  test 'ハッシュタグIDの必要性' do
    @micropost_hashtag.hashtag_id = nil
    assert_not @micropost_hashtag.valid?
  end

  test '同じデータが重複しないか' do
    micropost_hashtag_dup = @micropost_hashtag.dup
    @micropost_hashtag.save
    assert_not micropost_hashtag_dup.valid?
  end
end
