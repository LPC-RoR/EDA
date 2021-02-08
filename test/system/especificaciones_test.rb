require "application_system_test_case"

class EspecificacionesTest < ApplicationSystemTestCase
  setup do
    @especificacion = especificaciones(:one)
  end

  test "visiting the index" do
    visit especificaciones_url
    assert_selector "h1", text: "Especificaciones"
  end

  test "creating a Especificacion" do
    visit especificaciones_url
    click_on "New Especificacion"

    fill_in "Detalle", with: @especificacion.detalle
    fill_in "Especificacion", with: @especificacion.especificacion
    fill_in "Etapa", with: @especificacion.etapa_id
    fill_in "Orden", with: @especificacion.orden
    fill_in "Tabla", with: @especificacion.tabla_id
    click_on "Create Especificacion"

    assert_text "Especificacion was successfully created"
    click_on "Back"
  end

  test "updating a Especificacion" do
    visit especificaciones_url
    click_on "Edit", match: :first

    fill_in "Detalle", with: @especificacion.detalle
    fill_in "Especificacion", with: @especificacion.especificacion
    fill_in "Etapa", with: @especificacion.etapa_id
    fill_in "Orden", with: @especificacion.orden
    fill_in "Tabla", with: @especificacion.tabla_id
    click_on "Update Especificacion"

    assert_text "Especificacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Especificacion" do
    visit especificaciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Especificacion was successfully destroyed"
  end
end
