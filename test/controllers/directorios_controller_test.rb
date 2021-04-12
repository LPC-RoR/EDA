require 'test_helper'

class DirectoriosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @directorio = directorios(:one)
  end

  test "should get index" do
    get directorios_url
    assert_response :success
  end

  test "should get new" do
    get new_directorio_url
    assert_response :success
  end

  test "should create directorio" do
    assert_difference('Directorio.count') do
      post directorios_url, params: { directorio: { directorio: @directorio.directorio, proyecto_id: @directorio.proyecto_id } }
    end

    assert_redirected_to directorio_url(Directorio.last)
  end

  test "should show directorio" do
    get directorio_url(@directorio)
    assert_response :success
  end

  test "should get edit" do
    get edit_directorio_url(@directorio)
    assert_response :success
  end

  test "should update directorio" do
    patch directorio_url(@directorio), params: { directorio: { directorio: @directorio.directorio, proyecto_id: @directorio.proyecto_id } }
    assert_redirected_to directorio_url(@directorio)
  end

  test "should destroy directorio" do
    assert_difference('Directorio.count', -1) do
      delete directorio_url(@directorio)
    end

    assert_redirected_to directorios_url
  end
end
