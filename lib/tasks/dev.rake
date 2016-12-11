# frozen_string_literal: true
namespace :dev do
  task require: :require do
    Bundler.require(:development)
  end

  task pry: :require do
    binding.pry # rubocop:disable Lint/Debugger
  end
end
