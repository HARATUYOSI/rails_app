require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: 'aaaaaaa')
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = ' '
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = 'a' * 141
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end

  test "マイクロポスト削除時に、関連付けされたお気に入りモデルが削除されるかの検証" do
    assert_difference 'Favorite.count', -1 do
      microposts(:orange).destroy
    end
  end
end
