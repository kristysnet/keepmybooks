FactoryGirl.define do
  factory(:account) do
    sequence(:name) { |n| "name#{n}"}

    factory(:invalid_account) do
      name { nil }
    end

  end
end
