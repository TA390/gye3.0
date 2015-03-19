if Rails.env.development?
  %w[volunteer user ngo].each do |c|
    require_dependency File.join("app","models","#{c}.rb")
  end
end