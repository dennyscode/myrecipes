require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "DennyChef", email:"chefdenny@chef.com",
                        password: "password", password_confirmation: "password")
  end

  test 'reject an invalid edit' do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: {chefname:" ", email: "denny@chef.com"} }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test 'accept valid signup' do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path, params: {chef: { chefname:"denny1", email: "denny1@test.de" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "denny1", @chef.chefname
    assert_match "denny1@test.de", @chef.email
  end

end
