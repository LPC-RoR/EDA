require 'test_helper'

class TextosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @texto = textos(:one)
  end

  test "should get index" do
    get textos_url
    assert_response :success
  end

  test "should get new" do
    get new_texto_url
    assert_response :success
  end

  test "should create texto" do
    assert_difference('Texto.count') do
      post textos_url, params: { texto: { calificacion: @texto.calificacion, publicacion_id: @texto.publicacion_id, texto: @texto.texto } }
    end

    assert_redirected_to texto_url(Texto.last)
  end

  test "should show texto" do
    get texto_url(@texto)
    assert_response :success
  end

  test "should get edit" do
    get edit_texto_url(@texto)
    assert_response :success
  end

  test "should update texto" do
    patch texto_url(@texto), params: { texto: { calificacion: @texto.calificacion, publicacion_id: @texto.publicacion_id, texto: @texto.texto } }
    assert_redirected_to texto_url(@texto)
  end

  test "should destroy texto" do
    assert_difference('Texto.count', -1) do
      delete texto_url(@texto)
    end

    assert_redirected_to textos_url
  end
end
