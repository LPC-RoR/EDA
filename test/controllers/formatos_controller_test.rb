require 'test_helper'

class FormatosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @formato = formatos(:one)
  end

  test "should get index" do
    get formatos_url
    assert_response :success
  end

  test "should get new" do
    get new_formato_url
    assert_response :success
  end

  test "should create formato" do
    assert_difference('Formato.count') do
      post formatos_url, params: { formato: { formato: @formato.formato, perfil_id: @formato.perfil_id } }
    end

    assert_redirected_to formato_url(Formato.last)
  end

  test "should show formato" do
    get formato_url(@formato)
    assert_response :success
  end

  test "should get edit" do
    get edit_formato_url(@formato)
    assert_response :success
  end

  test "should update formato" do
    patch formato_url(@formato), params: { formato: { formato: @formato.formato, perfil_id: @formato.perfil_id } }
    assert_redirected_to formato_url(@formato)
  end

  test "should destroy formato" do
    assert_difference('Formato.count', -1) do
      delete formato_url(@formato)
    end

    assert_redirected_to formatos_url
  end
end
