require "application_system_test_case"

class OrigenesTest < ApplicationSystemTestCase
  setup do
    @origen = origenes(:one)
  end

  test "visiting the index" do
    visit origenes_url
    assert_selector "h1", text: "Origenes"
  end

  test "creating a Origen" do
    visit origenes_url
    click_on "New Origen"

    fill_in "Publicacion", with: @origen.publicacion_id
    fill_in "Repositorio", with: @origen.repositorio_id
    click_on "Create Origen"

    assert_text "Origen was successfully created"
    click_on "Back"
  end

  test "updating a Origen" do
    visit origenes_url
    click_on "Edit", match: :first

    fill_in "Publicacion", with: @origen.publicacion_id
    fill_in "Repositorio", with: @origen.repositorio_id
    click_on "Update Origen"

    assert_text "Origen was successfully updated"
    click_on "Back"
  end

  test "destroying a Origen" do
    visit origenes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Origen was successfully destroyed"
  end
end
