require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @card = cards(:one)
  end

  test "should get index" do
    get cards_url
    assert_response :success
  end

  test "should get new" do
    get new_card_url
    assert_response :success
  end

  test "should create card" do
    assert_difference('Card.count') do
      post cards_url, params: { card: { brand: @card.brand, customer_id: @card.customer_id, deafult: @card.deafult, exp_month: @card.exp_month, exp_year: @card.exp_year, last_4: @card.last_4, stripe_card_id: @card.stripe_card_id } }
    end

    assert_redirected_to card_url(Card.last)
  end

  test "should show card" do
    get card_url(@card)
    assert_response :success
  end

  test "should get edit" do
    get edit_card_url(@card)
    assert_response :success
  end

  test "should update card" do
    patch card_url(@card), params: { card: { brand: @card.brand, customer_id: @card.customer_id, deafult: @card.deafult, exp_month: @card.exp_month, exp_year: @card.exp_year, last_4: @card.last_4, stripe_card_id: @card.stripe_card_id } }
    assert_redirected_to card_url(@card)
  end

  test "should destroy card" do
    assert_difference('Card.count', -1) do
      delete card_url(@card)
    end

    assert_redirected_to cards_url
  end
end
