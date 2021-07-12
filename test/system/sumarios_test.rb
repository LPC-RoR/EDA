require "application_system_test_case"

class SumariosTest < ApplicationSystemTestCase
  setup do
    @sumario = sumarios(:one)
  end

  test "visiting the index" do
    visit sumarios_url
    assert_selector "h1", text: "Sumarios"
  end

  test "creating a Sumario" do
    visit sumarios_url
    click_on "New Sumario"

    fill_in "Clave", with: @sumario.clave
    fill_in "Encabezado", with: @sumario.encabezado_id
    fill_in "Valor", with: @sumario.valor
    click_on "Create Sumario"

    assert_text "Sumario was successfully created"
    click_on "Back"
  end

  test "updating a Sumario" do
    visit sumarios_url
    click_on "Edit", match: :first

    fill_in "Clave", with: @sumario.clave
    fill_in "Encabezado", with: @sumario.encabezado_id
    fill_in "Valor", with: @sumario.valor
    click_on "Update Sumario"

    assert_text "Sumario was successfully updated"
    click_on "Back"
  end

  test "destroying a Sumario" do
    visit sumarios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sumario was successfully destroyed"
  end
end
