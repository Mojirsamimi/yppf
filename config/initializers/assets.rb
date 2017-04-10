# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( dashboard.css )
Rails.application.config.assets.precompile += %w( Budget.png )
Rails.application.config.assets.precompile += %w( Budget2.png )
Rails.application.config.assets.precompile += %w( Budget3.png )
Rails.application.config.assets.precompile += %w( Logo.png )
Rails.application.config.assets.precompile += %w( Logo2.png )
Rails.application.config.assets.precompile += %w( Logo3.png )
Rails.application.config.assets.precompile += %w( Trend.png )
Rails.application.config.assets.precompile += %w( Trend2.png )
Rails.application.config.assets.precompile += %w( Trend3.png )
Rails.application.config.assets.precompile += %w( Calendar.png )
Rails.application.config.assets.precompile += %w( Calendar2.png )
Rails.application.config.assets.precompile += %w( Calendar3.png )
Rails.application.config.assets.precompile += %w( Compare.png )
Rails.application.config.assets.precompile += %w( Compare2.png )
Rails.application.config.assets.precompile += %w( Compare3.png )
Rails.application.config.assets.precompile += ['rollover.js', 'highcharts.js']


# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
