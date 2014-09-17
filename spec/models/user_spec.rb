require 'rails_helper'
# require 'devise'

RSpec.describe User, :type => :model do

  it { should have_one :library }
  it { should have_one :wanted_list }

  before do
    Fabricate(:user)
  end
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_uniqueness_of :email }

  context "User wants to reset password" do
    let!(:user) { Fabricate(:user) }
    it "sends an email to reset password" do
      expect { user.send_reset_password_instructions }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
