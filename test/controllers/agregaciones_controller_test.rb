require 'test_helper'

class AgregacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agregacion = agregaciones(:one)
  end

  test "should get index" do
    get agregaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_agregacion_url
    assert_response :success
  end

  test "should create agregacion" do
    assert_difference('Agregacion.count') do
      post agregaciones_url, params: { agregacion: { categoria_id: @agregacion.categoria_id, concepto_id: @agregacion.concepto_id } }
    end

    assert_redirected_to agregacion_url(Agregacion.last)
  end

  test "should show agregacion" do
    get agregacion_url(@agregacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_agregacion_url(@agregacion)
    assert_response :success
  end

  test "should update agregacion" do
    patch agregacion_url(@agregacion), params: { agregacion: { categoria_id: @agregacion.categoria_id, concepto_id: @agregacion.concepto_id } }
    assert_redirected_to agregacion_url(@agregacion)
  end

  test "should destroy agregacion" do
    assert_difference('Agregacion.count', -1) do
      delete agregacion_url(@agregacion)
    end

    assert_redirected_to agregaciones_url
  end
end
