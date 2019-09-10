require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
  end

  test "index including pagination" do
    login_as(@user)
    get users_path
    assert_template "users/index"
    assert_select "div.pagination", count: 2
    User.paginate(page: 1).each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
    end
  end
end
