require 'test_helper'

class LicenciasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @licencia = licencias(:one)
  end

  test "should get index" do
    get licencias_url
    assert_response :success
  end

  test "should get new" do
    get new_licencia_url
    assert_response :success
  end

  test "should create licencia" do
    assert_difference('Licencia.count') do
      post licencias_url, params: { licencia: { n_meses: @licencia.n_meses, perfil_id: @licencia.perfil_id } }
    end

    assert_redirected_to licencia_url(Licencia.last)
  end

  test "should show licencia" do
    get licencia_url(@licencia)
    assert_response :success
  end

  test "should get edit" do
    get edit_licencia_url(@licencia)
    assert_response :success
  end

  test "should update licencia" do
    patch licencia_url(@licencia), params: { licencia: { n_meses: @licencia.n_meses, perfil_id: @licencia.perfil_id } }
    assert_redirected_to licencia_url(@licencia)
  end

  test "should destroy licencia" do
    assert_difference('Licencia.count', -1) do
      delete licencia_url(@licencia)
    end

    assert_redirected_to licencias_url
  end
end
