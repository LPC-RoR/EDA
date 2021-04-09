require 'test_helper'

class TipoPublicacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tipo_publicacion = tipo_publicaciones(:one)
  end

  test "should get index" do
    get tipo_publicaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_tipo_publicacion_url
    assert_response :success
  end

  test "should create tipo_publicacion" do
    assert_difference('TipoPublicacion.count') do
      post tipo_publicaciones_url, params: { tipo_publicacion: { ejemplo: @tipo_publicacion.ejemplo, redireccion: @tipo_publicacion.redireccion, tipo_publicacion: @tipo_publicacion.tipo_publicacion } }
    end

    assert_redirected_to tipo_publicacion_url(TipoPublicacion.last)
  end

  test "should show tipo_publicacion" do
    get tipo_publicacion_url(@tipo_publicacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_tipo_publicacion_url(@tipo_publicacion)
    assert_response :success
  end

  test "should update tipo_publicacion" do
    patch tipo_publicacion_url(@tipo_publicacion), params: { tipo_publicacion: { ejemplo: @tipo_publicacion.ejemplo, redireccion: @tipo_publicacion.redireccion, tipo_publicacion: @tipo_publicacion.tipo_publicacion } }
    assert_redirected_to tipo_publicacion_url(@tipo_publicacion)
  end

  test "should destroy tipo_publicacion" do
    assert_difference('TipoPublicacion.count', -1) do
      delete tipo_publicacion_url(@tipo_publicacion)
    end

    assert_redirected_to tipo_publicaciones_url
  end
end
