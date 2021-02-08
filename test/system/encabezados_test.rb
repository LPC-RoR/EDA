require "application_system_test_case"

class EncabezadosTest < ApplicationSystemTestCase
  setup do
    @encabezado = encabezados(:one)
  end

  test "visiting the index" do
    visit encabezados_url
    assert_selector "h1", text: "Encabezados"
  end

  test "creating a Encabezado" do
    visit encabezados_url
    click_on "New Encabezado"

    fill_in "Encabezado", with: @encabezado.encabezado
    fill_in "Orden", with: @encabezado.orden
    fill_in "Tipo", with: @encabezado.tipo
    click_on "Create Encabezado"

    assert_text "Encabezado was successfully created"
    click_on "Back"
  end

  test "updating a Encabezado" do
    visit encabezados_url
    click_on "Edit", match: :first

    fill_in "Encabezado", with: @encabezado.encabezado
    fill_in "Orden", with: @encabezado.orden
    fill_in "Tipo", with: @encabezado.tipo
    click_on "Update Encabezado"

    assert_text "Encabezado was successfully updated"
    click_on "Back"
  end

  test "destroying a Encabezado" do
    visit encabezados_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Encabezado was successfully destroyed"
  end
end
