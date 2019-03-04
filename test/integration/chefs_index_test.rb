require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "DennyChef", email:"chefdenny@chef.com",
                        password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "Denny2Chef", email:"chef2denny@chef.com",
                        password: "password", password_confirmation: "password")

  end

  test 'should get chefs-index' do
    get chefs_url
    assert_response :success
  end

  test 'should get chefs listing' do
    get chefs_path
    assert_template 'chefs/index'
    # assert_match @chef.chefname, response.body
    # assert_match @chef2.chefname, response.body
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname.capitalize
  end
end
