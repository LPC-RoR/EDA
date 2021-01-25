require "application_system_test_case"

class CoautoresTest < ApplicationSystemTestCase
  setup do
    @coautor = coautores(:one)
  end

  test "visiting the index" do
    visit coautores_url
    assert_selector "h1", text: "Coautores"
  end

  test "creating a Coautor" do
    visit coautores_url
    click_on "New Coautor"

    fill_in "Perfil", with: @coautor.perfil_id
    fill_in "Proyecto", with: @coautor.proyecto_id
    click_on "Create Coautor"

    assert_text "Coautor was successfully created"
    click_on "Back"
  end

  test "updating a Coautor" do
    visit coautores_url
    click_on "Edit", match: :first

    fill_in "Perfil", with: @coautor.perfil_id
    fill_in "Proyecto", with: @coautor.proyecto_id
    click_on "Update Coautor"

    assert_text "Coautor was successfully updated"
    click_on "Back"
  end

  test "destroying a Coautor" do
    visit coautores_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Coautor was successfully destroyed"
  end
end
