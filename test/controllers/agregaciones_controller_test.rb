require 'test_helper'

class AgregacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agregacioneses = agregaciones(:one)
  end

  test "should get index" do
    get agregaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_agregacioneses_url
    assert_response :success
  end

  test "should create agregacioneses" do
    assert_difference('Agregacion.count') do
      post agregaciones_url, params: { agregacioneses: { categoria_id: @agregacioneses.categoria_id, concepto_id: @agregacioneses.concepto_id } }
    end

    assert_redirected_to agregacioneses_url(Agregacion.last)
  end

  test "should show agregacioneses" do
    get agregacioneses_url(@agregacioneses)
    assert_response :success
  end

  test "should get edit" do
    get edit_agregacioneses_url(@agregacioneses)
    assert_response :success
  end

  test "should update agregacioneses" do
    patch agregacioneses_url(@agregacioneses), params: { agregacioneses: { categoria_id: @agregacioneses.categoria_id, concepto_id: @agregacioneses.concepto_id } }
    assert_redirected_to agregacioneses_url(@agregacioneses)
  end

  test "should destroy agregacioneses" do
    assert_difference('Agregacion.count', -1) do
      delete agregacioneses_url(@agregacioneses)
    end

    assert_redirected_to agregaciones_url
  end
end
