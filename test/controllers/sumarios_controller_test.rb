require 'test_helper'

class SumariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sumario = sumarios(:one)
  end

  test "should get index" do
    get sumarios_url
    assert_response :success
  end

  test "should get new" do
    get new_sumario_url
    assert_response :success
  end

  test "should create sumario" do
    assert_difference('Sumario.count') do
      post sumarios_url, params: { sumario: { clave: @sumario.clave, encabezado_id: @sumario.encabezado_id, valor: @sumario.valor } }
    end

    assert_redirected_to sumario_url(Sumario.last)
  end

  test "should show sumario" do
    get sumario_url(@sumario)
    assert_response :success
  end

  test "should get edit" do
    get edit_sumario_url(@sumario)
    assert_response :success
  end

  test "should update sumario" do
    patch sumario_url(@sumario), params: { sumario: { clave: @sumario.clave, encabezado_id: @sumario.encabezado_id, valor: @sumario.valor } }
    assert_redirected_to sumario_url(@sumario)
  end

  test "should destroy sumario" do
    assert_difference('Sumario.count', -1) do
      delete sumario_url(@sumario)
    end

    assert_redirected_to sumarios_url
  end
end
