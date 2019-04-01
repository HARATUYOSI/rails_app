require 'test_helper'

class AddFavoritesTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:archer)
    log_in_as(@user)
  end

  test "お気に入り一覧" do
    get favorites_user_path(@user)
    assert_not @user.favorite_microposts.empty?
    assert_match @user.favorite_microposts.count.to_s, response.body
    @user.favorite_microposts.each do |fav_micropost|
      assert_match fav_micropost.content, response.body
    end
  end

  test "標準的なお気に入り登録" do
    assert_difference '@user.favorite_microposts.count', 1 do
      post favorites_path, params: {micropost_id: microposts(:tau_manifesto).id}
    end
  end

  test "Ajaxを用いたお気に入り登録" do
    assert_difference '@user.favorite_microposts.count', 1 do
      post favorites_path, xhr: true, params: {micropost_id: microposts(:tau_manifesto).id}
    end
  end

  test "標準的なお気に入り解除" do
    microposts(:tau_manifesto).favorite(@user)
    favorite = microposts(:tau_manifesto).favorites.find_by(user_id: @user.id)
    assert_difference '@user.favorite_microposts.count', -1 do
      delete favorite_path(favorite)
    end
  end

  test "Ajaxを用いたお気に入り解除" do
    microposts(:tau_manifesto).favorite(@user)
    favorite = microposts(:tau_manifesto).favorites.find_by(user_id: @user.id)
    assert_difference '@user.favorite_microposts.count', -1 do
      delete favorite_path(favorite), xhr: true
    end
  end
end
