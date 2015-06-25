require 'spec_helper'

describe "Static pages" do
	subject { page }

	describe "Home page" do
		before { visit root_path }
		it { should have_content('Field Note') }
		it { should have_title(full_title('')) }
		it { should_not have_title('| Home') }

		describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:note, user: user, body: "Lorem ipsum")
        FactoryGirl.create(:note, user: user, body: "Dolor sit amet")
        sign_in user
        visit root_path
      end
    end
  end

	describe "About page" do
		before { visit about_path }
		it { should have_content('About') }
		it { should have_title(full_title('About')) }
	end
end
