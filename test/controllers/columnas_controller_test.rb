require 'test_helper'

class ColumnasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @columna = columnas(:one)
  end

  test "should get index" do
    get columnas_url
    assert_response :success
  end

  test "should get new" do
    get new_columna_url
    assert_response :success
  end

  test "should create columna" do
    assert_difference('Columna.count') do
      post columnas_url, params: { columna: { linea_id: @columna.linea_id, orden: @columna.orden } }
    end

    assert_redirected_to columna_url(Columna.last)
  end

  test "should show columna" do
    get columna_url(@columna)
    assert_response :success
  end

  test "should get edit" do
    get edit_columna_url(@columna)
    assert_response :success
  end

  test "should update columna" do
    patch columna_url(@columna), params: { columna: { linea_id: @columna.linea_id, orden: @columna.orden } }
    assert_redirected_to columna_url(@columna)
  end

  test "should destroy columna" do
    assert_difference('Columna.count', -1) do
      delete columna_url(@columna)
    end

    assert_redirected_to columnas_url
  end
end
