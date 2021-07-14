require 'test_helper'

class CampoCargasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @campo_carga = campo_cargas(:one)
  end

  test "should get index" do
    get campo_cargas_url
    assert_response :success
  end

  test "should get new" do
    get new_campo_carga_url
    assert_response :success
  end

  test "should create campo_carga" do
    assert_difference('CampoCarga.count') do
      post campo_cargas_url, params: { campo_carga: { campo_carga: @campo_carga.campo_carga, campo_tabla: @campo_carga.campo_tabla, formato_carga_id: @campo_carga.formato_carga_id } }
    end

    assert_redirected_to campo_carga_url(CampoCarga.last)
  end

  test "should show campo_carga" do
    get campo_carga_url(@campo_carga)
    assert_response :success
  end

  test "should get edit" do
    get edit_campo_carga_url(@campo_carga)
    assert_response :success
  end

  test "should update campo_carga" do
    patch campo_carga_url(@campo_carga), params: { campo_carga: { campo_carga: @campo_carga.campo_carga, campo_tabla: @campo_carga.campo_tabla, formato_carga_id: @campo_carga.formato_carga_id } }
    assert_redirected_to campo_carga_url(@campo_carga)
  end

  test "should destroy campo_carga" do
    assert_difference('CampoCarga.count', -1) do
      delete campo_carga_url(@campo_carga)
    end

    assert_redirected_to campo_cargas_url
  end
end
