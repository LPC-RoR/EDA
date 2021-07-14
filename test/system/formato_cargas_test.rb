require "application_system_test_case"

class FormatoCargasTest < ApplicationSystemTestCase
  setup do
    @formato_carga = formato_cargas(:one)
  end

  test "visiting the index" do
    visit formato_cargas_url
    assert_selector "h1", text: "Formato Cargas"
  end

  test "creating a Formato carga" do
    visit formato_cargas_url
    click_on "New Formato Carga"

    fill_in "Formato carga", with: @formato_carga.formato_carga
    click_on "Create Formato carga"

    assert_text "Formato carga was successfully created"
    click_on "Back"
  end

  test "updating a Formato carga" do
    visit formato_cargas_url
    click_on "Edit", match: :first

    fill_in "Formato carga", with: @formato_carga.formato_carga
    click_on "Update Formato carga"

    assert_text "Formato carga was successfully updated"
    click_on "Back"
  end

  test "destroying a Formato carga" do
    visit formato_cargas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Formato carga was successfully destroyed"
  end
end
