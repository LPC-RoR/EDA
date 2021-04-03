require "application_system_test_case"

class LicenciasTest < ApplicationSystemTestCase
  setup do
    @licencia = licencias(:one)
  end

  test "visiting the index" do
    visit licencias_url
    assert_selector "h1", text: "Licencias"
  end

  test "creating a Licencia" do
    visit licencias_url
    click_on "New Licencia"

    fill_in "N meses", with: @licencia.n_meses
    fill_in "Perfil", with: @licencia.perfil_id
    click_on "Create Licencia"

    assert_text "Licencia was successfully created"
    click_on "Back"
  end

  test "updating a Licencia" do
    visit licencias_url
    click_on "Edit", match: :first

    fill_in "N meses", with: @licencia.n_meses
    fill_in "Perfil", with: @licencia.perfil_id
    click_on "Update Licencia"

    assert_text "Licencia was successfully updated"
    click_on "Back"
  end

  test "destroying a Licencia" do
    visit licencias_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Licencia was successfully destroyed"
  end
end
