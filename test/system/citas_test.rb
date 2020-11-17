require "application_system_test_case"

class CitasTest < ApplicationSystemTestCase
  setup do
    @cita = citas(:one)
  end

  test "visiting the index" do
    visit citas_url
    assert_selector "h1", text: "Citas"
  end

  test "creating a Cita" do
    visit citas_url
    click_on "New Cita"

    fill_in "Publicacion", with: @cita.publicacion_id
    fill_in "Texto", with: @cita.texto_id
    click_on "Create Cita"

    assert_text "Cita was successfully created"
    click_on "Back"
  end

  test "updating a Cita" do
    visit citas_url
    click_on "Edit", match: :first

    fill_in "Publicacion", with: @cita.publicacion_id
    fill_in "Texto", with: @cita.texto_id
    click_on "Update Cita"

    assert_text "Cita was successfully updated"
    click_on "Back"
  end

  test "destroying a Cita" do
    visit citas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cita was successfully destroyed"
  end
end
