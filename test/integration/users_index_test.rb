require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = create(:new_user, :admin)
    @non_admin = create(:new_user)
    15.times do
      create(:new_user)
    end
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
   assert_select 'div.pagination', count: 2
    assert_select 'a[href=?]', '/users?page=1', count: 2
    assert_select 'a[href=?]', '/users?page=2', count: 4
    first_page_of_users = User.paginate(page: 1, per_page: 10)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "no index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_redirected_to root_url
  end
  
end
