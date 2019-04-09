require 'test_helper'

class HashtagInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @hash_micropost = @user.microposts.create(content: '#tt')
  end

  test "ハッシュタグ付きの一覧を確認" do
    get '/hashtag/test'
    assert_template 'microposts/hashtag'
    assert_match '#test',response.body
  end

  test "存在しないハッシュタグ付きの投稿一覧を確認" do
    get '/hashtag/no_hashtag'
    assert_template 'microposts/hashtag'
    assert_match 'No results for #no_hashtag',response.body
  end

  test "ハッシュタグ付きの投稿を削除した時、他に同じハッシュタグつきの投稿がなければ、関連するハッシュタグテーブルのハッシュタグを削除する" do
    log_in_as(@user)
    get root_path
    delete micropost_path(@hash_micropost)
    assert_nil Hashtag.find_by(name: 'tt')
  end

end
