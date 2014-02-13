FactoryGirl.define do
  factory(:category) do
    sequence(:name) { |n| "name#{n}"}

    factory(:invalid_category) do
      name { nil }
    end
    factory(:sub_category) do
      parent { create(:category) }
    end

  end
end
