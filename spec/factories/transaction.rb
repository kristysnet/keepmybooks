FactoryGirl.define do
  factory(:transaction) do
    sequence(:receiver) { |n| "receiver#{n}"}
    sequence(:transaction_date) { |n| Time.now + n.days }
    sequence(:amount) { |n| n }
    category
    account

    factory(:invalid_transaction) do
      receiver { nil }
    end
    factory(:expense_transaction) do
      deposit { false }
    end
    factory(:deposit_transaction) do
      deposit { true }
    end

  end
end
