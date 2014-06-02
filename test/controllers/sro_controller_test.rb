# -*- encoding : utf-8 -*-
require 'test_helper'

class SroControllerTest < ActionController::TestCase
  test "should get cr_sro" do
    get :cr_sro
    assert_response :success
  end

  test "should get del_sro" do
    get :del_sro
    assert_response :success
  end

  test "should get found_sro" do
    get :found_sro
    assert_response :success
  end

end
