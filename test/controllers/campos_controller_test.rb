require 'test_helper'

class CamposControllerTest < ActionDispatch::IntegrationTest
  setup do
    @campo = campos(:one)
  end

  test "should get index" do
    get campos_url
    assert_response :success
  end

  test "should get new" do
    get new_campo_url
    assert_response :success
  end

  test "should create campo" do
    assert_difference('Campo.count') do
      post campos_url, params: { campo: { campo: @campo.campo, cursiva: @campo.cursiva, negrita: @campo.negrita, orden: @campo.orden } }
    end

    assert_redirected_to campo_url(Campo.last)
  end

  test "should show campo" do
    get campo_url(@campo)
    assert_response :success
  end

  test "should get edit" do
    get edit_campo_url(@campo)
    assert_response :success
  end

  test "should update campo" do
    patch campo_url(@campo), params: { campo: { campo: @campo.campo, cursiva: @campo.cursiva, negrita: @campo.negrita, orden: @campo.orden } }
    assert_redirected_to campo_url(@campo)
  end

  test "should destroy campo" do
    assert_difference('Campo.count', -1) do
      delete campo_url(@campo)
    end

    assert_redirected_to campos_url
  end
end
