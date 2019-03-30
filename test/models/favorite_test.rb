require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  def setup
    @favorite = Favorite.new(user_id: users(:archer).id,micropost_id: microposts(:orange).id)
  end

  test "有効性" do
    assert @favorite.valid?
  end

  test "ユーザーIDの必要性" do
    @favorite.user_id = nil
    assert_not @favorite.valid?
  end

  test "マイクロポストIDの必要性" do
    @favorite.micropost_id = nil
    assert_not @favorite.valid?
  end

  test "同じデータが重複しないか" do
    @favorite_dup = @favorite.dup
    assert_raise(ActiveRecord::RecordNotUnique) do
      @favorite.save
    end
  end
end
