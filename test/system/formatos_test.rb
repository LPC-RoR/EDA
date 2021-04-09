require "application_system_test_case"

class FormatosTest < ApplicationSystemTestCase
  setup do
    @formato = formatos(:one)
  end

  test "visiting the index" do
    visit formatos_url
    assert_selector "h1", text: "Formatos"
  end

  test "creating a Formato" do
    visit formatos_url
    click_on "New Formato"

    fill_in "Formato", with: @formato.formato
    fill_in "Perfil", with: @formato.perfil_id
    click_on "Create Formato"

    assert_text "Formato was successfully created"
    click_on "Back"
  end

  test "updating a Formato" do
    visit formatos_url
    click_on "Edit", match: :first

    fill_in "Formato", with: @formato.formato
    fill_in "Perfil", with: @formato.perfil_id
    click_on "Update Formato"

    assert_text "Formato was successfully updated"
    click_on "Back"
  end

  test "destroying a Formato" do
    visit formatos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Formato was successfully destroyed"
  end
end
