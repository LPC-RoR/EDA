require 'test_helper'

class ImagenesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @imagen = imagenes(:one)
  end

  test "should get index" do
    get imagenes_url
    assert_response :success
  end

  test "should get new" do
    get new_imagen_url
    assert_response :success
  end

  test "should create imagen" do
    assert_difference('Imagen.count') do
      post imagenes_url, params: { imagen: { imagen: @imagen.imagen, linea_id: @imagen.linea_id, nota: @imagen.nota, orden: @imagen.orden } }
    end

    assert_redirected_to imagen_url(Imagen.last)
  end

  test "should show imagen" do
    get imagen_url(@imagen)
    assert_response :success
  end

  test "should get edit" do
    get edit_imagen_url(@imagen)
    assert_response :success
  end

  test "should update imagen" do
    patch imagen_url(@imagen), params: { imagen: { imagen: @imagen.imagen, linea_id: @imagen.linea_id, nota: @imagen.nota, orden: @imagen.orden } }
    assert_redirected_to imagen_url(@imagen)
  end

  test "should destroy imagen" do
    assert_difference('Imagen.count', -1) do
      delete imagen_url(@imagen)
    end

    assert_redirected_to imagenes_url
  end
end
