require 'test_helper'

class FormatoCargasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @formato_carga = formato_cargas(:one)
  end

  test "should get index" do
    get formato_cargas_url
    assert_response :success
  end

  test "should get new" do
    get new_formato_carga_url
    assert_response :success
  end

  test "should create formato_carga" do
    assert_difference('FormatoCarga.count') do
      post formato_cargas_url, params: { formato_carga: { formato_carga: @formato_carga.formato_carga } }
    end

    assert_redirected_to formato_carga_url(FormatoCarga.last)
  end

  test "should show formato_carga" do
    get formato_carga_url(@formato_carga)
    assert_response :success
  end

  test "should get edit" do
    get edit_formato_carga_url(@formato_carga)
    assert_response :success
  end

  test "should update formato_carga" do
    patch formato_carga_url(@formato_carga), params: { formato_carga: { formato_carga: @formato_carga.formato_carga } }
    assert_redirected_to formato_carga_url(@formato_carga)
  end

  test "should destroy formato_carga" do
    assert_difference('FormatoCarga.count', -1) do
      delete formato_carga_url(@formato_carga)
    end

    assert_redirected_to formato_cargas_url
  end
end
