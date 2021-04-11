require 'test_helper'

class EtqContadoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @etq_contador = etq_contadores(:one)
  end

  test "should get index" do
    get etq_contadores_url
    assert_response :success
  end

  test "should get new" do
    get new_etq_contador_url
    assert_response :success
  end

  test "should create etq_contador" do
    assert_difference('EtqContador.count') do
      post etq_contadores_url, params: { etq_contador: { etiqueta_id: @etq_contador.etiqueta_id, publicacion_id: @etq_contador.publicacion_id } }
    end

    assert_redirected_to etq_contador_url(EtqContador.last)
  end

  test "should show etq_contador" do
    get etq_contador_url(@etq_contador)
    assert_response :success
  end

  test "should get edit" do
    get edit_etq_contador_url(@etq_contador)
    assert_response :success
  end

  test "should update etq_contador" do
    patch etq_contador_url(@etq_contador), params: { etq_contador: { etiqueta_id: @etq_contador.etiqueta_id, publicacion_id: @etq_contador.publicacion_id } }
    assert_redirected_to etq_contador_url(@etq_contador)
  end

  test "should destroy etq_contador" do
    assert_difference('EtqContador.count', -1) do
      delete etq_contador_url(@etq_contador)
    end

    assert_redirected_to etq_contadores_url
  end
end
