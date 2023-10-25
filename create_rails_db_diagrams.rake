# frozen_string_literal: true
# https://pastebin.com/gFFnBWgU

desc 'Create diagrams based on database current schema'
namespace :db do # rubocop:disable Metrics/BlockLength
  task diagrams: :environment do # rubocop:disable Metrics/BlockLength
    current_version = ActiveRecord::Migrator.current_version
    current_time = Time.zone.now.strftime '%d.%m.%Y %H:%m:%S'
    path_to_diagrams = Rails.root.join('doc')

    FileUtils.mkdir_p(path_to_diagrams)

    options = %w[
      filetype=png
      orientation=horizontal
    ]

    groups = {
      orders: %w[
        User
        Order
      ],
      blog: %w[
        Article
        Post
      ]
    }

    # complete diagram
    lines = [
      'rake erd',
      options.join(' '),
      "filename='#{path_to_diagrams}/erd_complete'",
      "title='#{current_time} - AppName complete diagram (v#{current_version})'"
    ]
    system(lines.join(' '))

    groups.each do |k, v|
      lines = [
        'rake erd',
        options.join(' '),
        "filename='#{path_to_diagrams}/erd_#{k}'",
        "only=#{v.join(',')}",
        "title='#{current_time} - AppName #{k.to_s.humanize} diagram (v#{current_version})'"
      ]
      system(lines.join(' '))
    end

    system("railroady -lamM | neato -Tpng > #{path_to_diagrams}/models_complete.png")
  end
end
