require 'test_helper'

class AlcancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @alcance = alcances(:one)
  end

  test "should get index" do
    get alcances_url
    assert_response :success
  end

  test "should get new" do
    get new_alcance_url
    assert_response :success
  end

  test "should create alcance" do
    assert_difference('Alcance.count') do
      post alcances_url, params: { alcance: { carpeta_id: @alcance.carpeta_id, reporte_id: @alcance.reporte_id } }
    end

    assert_redirected_to alcance_url(Alcance.last)
  end

  test "should show alcance" do
    get alcance_url(@alcance)
    assert_response :success
  end

  test "should get edit" do
    get edit_alcance_url(@alcance)
    assert_response :success
  end

  test "should update alcance" do
    patch alcance_url(@alcance), params: { alcance: { carpeta_id: @alcance.carpeta_id, reporte_id: @alcance.reporte_id } }
    assert_redirected_to alcance_url(@alcance)
  end

  test "should destroy alcance" do
    assert_difference('Alcance.count', -1) do
      delete alcance_url(@alcance)
    end

    assert_redirected_to alcances_url
  end
end
