require "application_system_test_case"

class MetodologiasTest < ApplicationSystemTestCase
  setup do
    @metodologia = metodologias(:one)
  end

  test "visiting the index" do
    visit metodologias_url
    assert_selector "h1", text: "Metodologias"
  end

  test "creating a Metodologia" do
    visit metodologias_url
    click_on "New Metodologia"

    fill_in "Metodologia", with: @metodologia.metodologia
    fill_in "Publicacion", with: @metodologia.publicacion_id
    click_on "Create Metodologia"

    assert_text "Metodologia was successfully created"
    click_on "Back"
  end

  test "updating a Metodologia" do
    visit metodologias_url
    click_on "Edit", match: :first

    fill_in "Metodologia", with: @metodologia.metodologia
    fill_in "Publicacion", with: @metodologia.publicacion_id
    click_on "Update Metodologia"

    assert_text "Metodologia was successfully updated"
    click_on "Back"
  end

  test "destroying a Metodologia" do
    visit metodologias_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Metodologia was successfully destroyed"
  end
end
