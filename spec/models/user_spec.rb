require 'rails_helper'

RSpec.describe User, :type => :model do
  context "Fields" do
    it{ should have_field(:admin).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it{ should have_field(:password_changed).of_type(Mongoid::Boolean).with_default_value_of(false) }
  end

  context "Custom methods" do
    context "#update_password" do
      context "when password hasn't changed" do
        let(:user){ FactoryGirl.create(:user, password_changed: false) }

        it "should not require current password when password hasn't changed" do
          expect(
            user.update_password(password: 'foobarbar', password_confirmation: 'foobarbar')
          ).to eql true
        end

        it "should update password when has not changed" do
          user.update_password(password: 'foobarbar', password_confirmation: 'foobarbar')
          user.reload

          expect(user.valid_password? 'foobarbar').to eql true
        end
      end

      context "when password has changed" do
        let(:user){ FactoryGirl.create(:user) }
        it "should require current password when password has changed" do
          expect(
            user.update_password(password: 'foobarbar', password_confirmation: 'foobarbar')
          ).to eql false
        end

        it "should update password when has changed" do
          user.update_password(
            current_password: 'foobarfoo', password: 'foobarbar',
            password_confirmation: 'foobarbar')
          user.reload

          expect(user.valid_password? 'foobarbar').to eql true
        end
      end
    end
  end
end
