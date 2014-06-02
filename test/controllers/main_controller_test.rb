# -*- encoding : utf-8 -*-
require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get show_prof" do
    get :show_prof
    assert_response :success
  end

  test "should get edit_prof" do
    get :edit_prof
    assert_response :success
  end

  test "should get cr_prof" do
    get :cr_prof
    assert_response :success
  end

  test "should get del_prof" do
    get :del_prof
    assert_response :success
  end

  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

end
