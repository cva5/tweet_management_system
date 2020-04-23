require 'rails_helper'

feature "AddNewTweets", :type => :feature do
  it "should require the user log in before adding a tweet" do
    password = "123456789"
    u = create( :user, password: password, password_confirmation: password )

    visit new_tweet_path

    within "#new_user" do
      fill_in "user_email", with: u.email
      fill_in "user_password", with: password
    end

    click_button "Log in"

    within "#new_tweet" do
      fill_in "tweet_body", with: "Post Body"
    end

    click_link_or_button "Create Tweet"

    expect( Tweet.count ).to eq(1)
    expect( Tweet.first.body).to eq( "Post Body")
  end

    it "should create a new tweet with a logged in user" do
    login_as create( :user ), scope: :user

    visit new_tweet_path

    within "#new_tweet" do
      fill_in "tweet_body", with: "Post Body"
    end

    click_link_or_button "Create Tweet"

    expect( Tweet.count ).to eq(1)
    expect( Tweet.first.body).to eq( "Post Body")

  end
end