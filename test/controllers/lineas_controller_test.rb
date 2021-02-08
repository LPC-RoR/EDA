require 'test_helper'

class LineasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @linea = lineas(:one)
  end

  test "should get index" do
    get lineas_url
    assert_response :success
  end

  test "should get new" do
    get new_linea_url
    assert_response :success
  end

  test "should create linea" do
    assert_difference('Linea.count') do
      post lineas_url, params: { linea: { linea: @linea.linea, orden: @linea.orden, tabla_id: @linea.tabla_id } }
    end

    assert_redirected_to linea_url(Linea.last)
  end

  test "should show linea" do
    get linea_url(@linea)
    assert_response :success
  end

  test "should get edit" do
    get edit_linea_url(@linea)
    assert_response :success
  end

  test "should update linea" do
    patch linea_url(@linea), params: { linea: { linea: @linea.linea, orden: @linea.orden, tabla_id: @linea.tabla_id } }
    assert_redirected_to linea_url(@linea)
  end

  test "should destroy linea" do
    assert_difference('Linea.count', -1) do
      delete linea_url(@linea)
    end

    assert_redirected_to lineas_url
  end
end
