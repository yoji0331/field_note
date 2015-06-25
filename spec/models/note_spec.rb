require 'spec_helper'

describe Note do
	let(:user) { FactoryGirl.create(:user) }
	before { @note = user.notes.build(body: "Test") }

	subject { @note }

	it { should respond_to(:body) }
	it { should respond_to(:user_id) }
	it { should respond_to(:lat) }
	it { should respond_to(:lng) }
	it { should respond_to(:weather) }
	it { should respond_to(:date) }
	it { should respond_to(:user) }
	its(:user) { should eq user }

	
	it { should be_valid }

	describe "when user_id is not present" do
		before { @note.user_id = nil }
		it { should_not be_valid }
	end

end