require 'test_helper'

class MetodologiasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @metodologia = metodologias(:one)
  end

  test "should get index" do
    get metodologias_url
    assert_response :success
  end

  test "should get new" do
    get new_metodologia_url
    assert_response :success
  end

  test "should create metodologia" do
    assert_difference('Metodologia.count') do
      post metodologias_url, params: { metodologia: { metodologia: @metodologia.metodologia, publicacion_id: @metodologia.publicacion_id } }
    end

    assert_redirected_to metodologia_url(Metodologia.last)
  end

  test "should show metodologia" do
    get metodologia_url(@metodologia)
    assert_response :success
  end

  test "should get edit" do
    get edit_metodologia_url(@metodologia)
    assert_response :success
  end

  test "should update metodologia" do
    patch metodologia_url(@metodologia), params: { metodologia: { metodologia: @metodologia.metodologia, publicacion_id: @metodologia.publicacion_id } }
    assert_redirected_to metodologia_url(@metodologia)
  end

  test "should destroy metodologia" do
    assert_difference('Metodologia.count', -1) do
      delete metodologia_url(@metodologia)
    end

    assert_redirected_to metodologias_url
  end
end
