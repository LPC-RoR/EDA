require 'test_helper'

class AsociacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asociacion = asociaciones(:one)
  end

  test "should get index" do
    get asociaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_asociacion_url
    assert_response :success
  end

  test "should create asociacion" do
    assert_difference('Asociacion.count') do
      post asociaciones_url, params: { asociacion: { proyecto_id: @asociacion.proyecto_id, publicacion_id: @asociacion.publicacion_id } }
    end

    assert_redirected_to asociacion_url(Asociacion.last)
  end

  test "should show asociacion" do
    get asociacion_url(@asociacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_asociacion_url(@asociacion)
    assert_response :success
  end

  test "should update asociacion" do
    patch asociacion_url(@asociacion), params: { asociacion: { proyecto_id: @asociacion.proyecto_id, publicacion_id: @asociacion.publicacion_id } }
    assert_redirected_to asociacion_url(@asociacion)
  end

  test "should destroy asociacion" do
    assert_difference('Asociacion.count', -1) do
      delete asociacion_url(@asociacion)
    end

    assert_redirected_to asociaciones_url
  end
end
