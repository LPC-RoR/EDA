require 'test_helper'

class EspecificacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @especificacion = especificaciones(:one)
  end

  test "should get index" do
    get especificaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_especificacion_url
    assert_response :success
  end

  test "should create especificacion" do
    assert_difference('Especificacion.count') do
      post especificaciones_url, params: { especificacion: { detalle: @especificacion.detalle, especificacion: @especificacion.especificacion, etapa_id: @especificacion.etapa_id, orden: @especificacion.orden, tabla_id: @especificacion.tabla_id } }
    end

    assert_redirected_to especificacion_url(Especificacion.last)
  end

  test "should show especificacion" do
    get especificacion_url(@especificacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_especificacion_url(@especificacion)
    assert_response :success
  end

  test "should update especificacion" do
    patch especificacion_url(@especificacion), params: { especificacion: { detalle: @especificacion.detalle, especificacion: @especificacion.especificacion, etapa_id: @especificacion.etapa_id, orden: @especificacion.orden, tabla_id: @especificacion.tabla_id } }
    assert_redirected_to especificacion_url(@especificacion)
  end

  test "should destroy especificacion" do
    assert_difference('Especificacion.count', -1) do
      delete especificacion_url(@especificacion)
    end

    assert_redirected_to especificaciones_url
  end
end
