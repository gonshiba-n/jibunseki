FactoryBot.define do
	factory :user do
		id {1}
		name { 'test_user' }
		sequence(:email) {|n| "test#{n}@example.com" }
		password { 'password' }

		trait :invalid do
			password {'pass'}
    end
	end
end