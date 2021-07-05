require 'test_helper'

class CaracterizacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @caracterizacion = caracterizaciones(:one)
  end

  test "should get index" do
    get caracterizaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_caracterizacion_url
    assert_response :success
  end

  test "should create caracterizacion" do
    assert_difference('Caracterizacion.count') do
      post caracterizaciones_url, params: { caracterizacion: { caracterizacion: @caracterizacion.caracterizacion, proyecto_id: @caracterizacion.proyecto_id } }
    end

    assert_redirected_to caracterizacion_url(Caracterizacion.last)
  end

  test "should show caracterizacion" do
    get caracterizacion_url(@caracterizacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_caracterizacion_url(@caracterizacion)
    assert_response :success
  end

  test "should update caracterizacion" do
    patch caracterizacion_url(@caracterizacion), params: { caracterizacion: { caracterizacion: @caracterizacion.caracterizacion, proyecto_id: @caracterizacion.proyecto_id } }
    assert_redirected_to caracterizacion_url(@caracterizacion)
  end

  test "should destroy caracterizacion" do
    assert_difference('Caracterizacion.count', -1) do
      delete caracterizacion_url(@caracterizacion)
    end

    assert_redirected_to caracterizaciones_url
  end
end
