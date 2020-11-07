require 'test_helper'

class OrigenesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @origen = origenes(:one)
  end

  test "should get index" do
    get origenes_url
    assert_response :success
  end

  test "should get new" do
    get new_origen_url
    assert_response :success
  end

  test "should create origen" do
    assert_difference('Origen.count') do
      post origenes_url, params: { origen: { publicacion_id: @origen.publicacion_id, repositorio_id: @origen.repositorio_id } }
    end

    assert_redirected_to origen_url(Origen.last)
  end

  test "should show origen" do
    get origen_url(@origen)
    assert_response :success
  end

  test "should get edit" do
    get edit_origen_url(@origen)
    assert_response :success
  end

  test "should update origen" do
    patch origen_url(@origen), params: { origen: { publicacion_id: @origen.publicacion_id, repositorio_id: @origen.repositorio_id } }
    assert_redirected_to origen_url(@origen)
  end

  test "should destroy origen" do
    assert_difference('Origen.count', -1) do
      delete origen_url(@origen)
    end

    assert_redirected_to origenes_url
  end
end
