require 'test_helper'

class EncabezadosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @encabezado = encabezados(:one)
  end

  test "should get index" do
    get encabezados_url
    assert_response :success
  end

  test "should get new" do
    get new_encabezado_url
    assert_response :success
  end

  test "should create encabezado" do
    assert_difference('Encabezado.count') do
      post encabezados_url, params: { encabezado: { encabezado: @encabezado.encabezado, orden: @encabezado.orden, tipo: @encabezado.tipo } }
    end

    assert_redirected_to encabezado_url(Encabezado.last)
  end

  test "should show encabezado" do
    get encabezado_url(@encabezado)
    assert_response :success
  end

  test "should get edit" do
    get edit_encabezado_url(@encabezado)
    assert_response :success
  end

  test "should update encabezado" do
    patch encabezado_url(@encabezado), params: { encabezado: { encabezado: @encabezado.encabezado, orden: @encabezado.orden, tipo: @encabezado.tipo } }
    assert_redirected_to encabezado_url(@encabezado)
  end

  test "should destroy encabezado" do
    assert_difference('Encabezado.count', -1) do
      delete encabezado_url(@encabezado)
    end

    assert_redirected_to encabezados_url
  end
end
