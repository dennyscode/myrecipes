require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef1 = Chef.create!(chefname: "Chef1", email:"chef1@chef.com",
                        password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "Chef2", email:"chef2@chef.com",
                        password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "DennyChef", email:"chefdenny@chef.com",
                        password: "password", password_confirmation: "password", admin: true)
  end

  test 'reject an invalid edit' do
    sign_in_as(@chef1, "password")
    get edit_chef_path(@chef1)
    assert_template 'chefs/edit'
    patch chef_path(@chef1), params: { chef: {chefname:" ", email: "denny@chef.com"} }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test 'accept valid edit' do
    sign_in_as(@chef1, "password")
    get edit_chef_path(@chef1)
    assert_template 'chefs/edit'
    patch chef_path, params: {chef: { chefname:"denny1", email: "denny1@test.de" } }
    assert_redirected_to @chef1
    assert_not flash.empty?
    @chef1.reload
    assert_match "denny1", @chef1.chefname
    assert_match "denny1@test.de", @chef1.email
  end

  test 'accept edit attempt by admin user' do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef1)
    assert_template 'chefs/edit'
    patch chef_path(@chef1), params: {chef: { chefname:"denny2", email: "denny2@test.de" } }
    assert_redirected_to @chef1
    assert_not flash.empty?
    @chef1.reload
    assert_match "denny2", @chef1.chefname
    assert_match "denny2@test.de", @chef1.email
  end

  test 'redirect edit attempt by another non-admin user' do
    sign_in_as(@chef1, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch chef_path(@chef2), params: {chef: { chefname: updated_name, email: updated_email } }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef2.reload
    assert_match "Chef2", @chef2.chefname
    assert_match "chef2@chef.com", @chef2.email
  end

end
