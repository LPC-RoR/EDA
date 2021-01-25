require 'test_helper'

class CoautoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coautor = coautores(:one)
  end

  test "should get index" do
    get coautores_url
    assert_response :success
  end

  test "should get new" do
    get new_coautor_url
    assert_response :success
  end

  test "should create coautor" do
    assert_difference('Coautor.count') do
      post coautores_url, params: { coautor: { perfil_id: @coautor.perfil_id, proyecto_id: @coautor.proyecto_id } }
    end

    assert_redirected_to coautor_url(Coautor.last)
  end

  test "should show coautor" do
    get coautor_url(@coautor)
    assert_response :success
  end

  test "should get edit" do
    get edit_coautor_url(@coautor)
    assert_response :success
  end

  test "should update coautor" do
    patch coautor_url(@coautor), params: { coautor: { perfil_id: @coautor.perfil_id, proyecto_id: @coautor.proyecto_id } }
    assert_redirected_to coautor_url(@coautor)
  end

  test "should destroy coautor" do
    assert_difference('Coautor.count', -1) do
      delete coautor_url(@coautor)
    end

    assert_redirected_to coautores_url
  end
end
