require 'rails_helper'

RSpec.describe 'Nyauth::Sessions' do
  let(:user) { create(:user) }

  feature 'sign in' do
    background { visit nyauth.new_session_path }

    scenario 'sign in user' do
      fill_in('session_service_email', with: user.email)
      fill_in('session_service_password', with: user.password)
      click_button('Sign in')

      expect(page).to have_content('sign in success')
    end

    scenario "can't sign in user" do
      click_button('Sign in')

      expect(page).to have_content('invalid')
    end

  end

  feature 'sign out' do
    background do
      sign_in(user)
    end

    scenario 'sign out user' do
      visit root_path
      click_link('Sign out')
      expect(page).to have_content('sign out')
    end
  end
end
