require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    @item = items(:one)
  end

  test "visiting the index" do
    visit items_url
    assert_selector "h1", text: "Items"
  end

  test "should create item" do
    visit items_url
    click_on "New item"

    fill_in "Content", with: @item.content
    fill_in "Context info", with: @item.context_info
    fill_in "Description", with: @item.description
    fill_in "Item", with: @item.item_id
    fill_in "Language", with: @item.language
    fill_in "Media", with: @item.media
    check "Published" if @item.published
    fill_in "Status", with: @item.status
    fill_in "Title", with: @item.title
    fill_in "User", with: @item.user_id
    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "should update Item" do
    visit item_url(@item)
    click_on "Edit this item", match: :first

    fill_in "Content", with: @item.content
    fill_in "Context info", with: @item.context_info
    fill_in "Description", with: @item.description
    fill_in "Item", with: @item.item_id
    fill_in "Language", with: @item.language
    fill_in "Media", with: @item.media
    check "Published" if @item.published
    fill_in "Status", with: @item.status
    fill_in "Title", with: @item.title
    fill_in "User", with: @item.user_id
    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  test "should destroy Item" do
    visit item_url(@item)
    click_on "Destroy this item", match: :first

    assert_text "Item was successfully destroyed"
  end
end
