require 'test_helper'

class SheetsControllerTest < ActionController::TestCase
  setup do
    @sheet = sheets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sheets)
  end

  test "should get new" do
    sign_in :user, users(:jason)
    get :new
    assert_response :success
  end

  test "should create sheet" do
    sign_in users(:jason)
    assert_difference('Sheet.count') do
      post :create, sheet: { description: @sheet.description}
    end

    assert_redirected_to sheet_path(assigns(:sheet))
  end

  test "should show sheet" do
    sign_in users(:jason)
    get :show, id: @sheet
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:jason)
    get :edit, id: @sheet
    assert_response :success
  end

  test "should update sheet" do
    sign_in users(:jason)
    patch :update, id: @sheet, sheet: { description: @sheet.description}
    assert_redirected_to sheet_path(assigns(:sheet))
  end

  test "should destroy sheet" do
    sign_in users(:jason)
    assert_difference('Sheet.count', -1) do
      delete :destroy, id: @sheet
    end

    assert_redirected_to sheets_path
  end
end
