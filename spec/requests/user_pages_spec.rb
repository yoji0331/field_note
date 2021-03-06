require 'spec_helper'

describe "User pages" do
	subject { page }

	describe "index" do
		let(:user) { FactoryGirl.create(:user) }
		
		before do
			sign_in user
			visit users_path
		end

		describe "delete links" do
			it { should_not have_link('delete') }

			describe "as an admin user" do
				let(:admin) { FactoryGirl.create(:admin) }
				before do
					sign_in admin
					visit users_path
				end

				it { should have_link('delete', href: user_path(User.first)) }
				it "should be able to delete another user" do
					expect do
						click_link('delete', match: :first)
					end.to change(User, :count).by(-1)
				end
				it { should_not have_link('delete', href: user_path(admin)) }
			end
		end
	end


	describe "signup page" do
		before { visit signup_path }
		it { should have_content('Sign up') }
		it { should have_title(full_title('Sign up')) }
	end

	describe "signup" do
		before { visit signup_path }
		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name", with: "Example User"
				fill_in "Email", with: "user@example.com"
				fill_in "Password", with: "foobar"
				fill_in "Confirmation", with: "foobar"
			end
			
		end
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit edit_user_path(user)
		end
		describe "page" do
			it { should have_content("Update your profile") }
			it { should have_title("Edit user") }
		end
		
		describe "with invalid information" do
			before { click_button "Save changes" }
			it { should have_content('error') }
		end
		describe "with valid information" do
			let(:new_name) { "New Name" }
			let(:new_email) { "new@example.com" }

			before do
				fill_in "Name", with: new_name
				fill_in "Email", with: new_email
				fill_in "Password", with: user.password
				fill_in "Confirm Password", with: user.password
				click_button "Save changes"
			end

			it { should have_title(new_name) }
			it { should have_link('Sign out', href: signout_path) }
			specify { expect(user.reload.name).to eq new_name }
			specify { expect(user.reload.email).to eq new_email }
		end
	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
    let!(:n1) { FactoryGirl.create(:note, user: user, body: "Foo") }
    let!(:n2) { FactoryGirl.create(:note, user: user, body: "Bar") }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "note" do
      it { should have_content(n1.body) }
      it { should have_content(n2.body) }
      it { should have_content(user.notes.count) }
    end
	end

end
