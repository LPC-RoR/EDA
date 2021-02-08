require 'test_helper'

class VersionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @version = versiones(:one)
  end

  test "should get index" do
    get versiones_url
    assert_response :success
  end

  test "should get new" do
    get new_version_url
    assert_response :success
  end

  test "should create version" do
    assert_difference('Version.count') do
      post versiones_url, params: { version: { estado: @version.estado, nota: @version.nota, proyecto_id: @version.proyecto_id, version: @version.version } }
    end

    assert_redirected_to version_url(Version.last)
  end

  test "should show version" do
    get version_url(@version)
    assert_response :success
  end

  test "should get edit" do
    get edit_version_url(@version)
    assert_response :success
  end

  test "should update version" do
    patch version_url(@version), params: { version: { estado: @version.estado, nota: @version.nota, proyecto_id: @version.proyecto_id, version: @version.version } }
    assert_redirected_to version_url(@version)
  end

  test "should destroy version" do
    assert_difference('Version.count', -1) do
      delete version_url(@version)
    end

    assert_redirected_to versiones_url
  end
end
