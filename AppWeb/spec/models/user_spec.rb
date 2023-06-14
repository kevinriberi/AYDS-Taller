# spec/models/user_spec.rb
require 'sinatra/activerecord'
require_relative '../../models/init.rb'


describe User do
  it "is valid with a username and email" do
    user = User.new(username: "Martincito28", email: "martinp@example.com", password_digest: "password")
    expect(user).to be_valid
  end

  it "is invalid without a username" do
    user = User.new(email: "roman10@example.com", password_digest: "password")
    expect(user).not_to be_valid
  end

  it "is invalid without an email address" do
    user = User.new(username: "RR10", password_digest: "password")
    expect(user).not_to be_valid
  end

  it "is invalid without an password" do
    user = User.new(username: "RR10", email: "roman10@gmail.com")
    expect(user).not_to be_valid
  end

  it "is invalid with a duplicate email address" do
    existing_user = User.create(username: "Messi10", email: "messi@example.com", password_digest: "password")
    user = User.new(username: "argento", email: "messi@example.com", password_digest: "password")
    expect(user).not_to be_valid
  end
end