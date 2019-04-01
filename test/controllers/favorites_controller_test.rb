require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "お気に入り登録するためにはログインが必要" do
    assert_no_difference 'Favorite.count' do
      post favorites_path
    end
    assert_redirected_to login_url
  end

  test "お気に入り解除のためにはログインが必要" do
    assert_no_difference 'Favorite.count' do
      delete favorite_path(favorites(:one))
    end
    assert_redirected_to login_url
  end
end
