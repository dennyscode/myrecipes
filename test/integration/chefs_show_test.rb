require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "DennyChef", email:"chefdenny@chef.com",
                        password: "password", password_confirmation: "password")
    @recipe = Recipe.create!(name:"Applepie", description: "Tasty, sugary and delicious cake", chef: @chef)
    @recipe2 = @chef.recipes.build(name:"Chicken", description: "Great Chicken Dish")
    @recipe2.save
  end

  test 'should get chefs´show' do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end

end
