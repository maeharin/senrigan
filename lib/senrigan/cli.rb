require 'senrigan'
require 'thor'

module Senrigan
  class Cli < ::Thor
    class_option :"display-edge", type: :boolean
    class_option :vertical, type: :boolean

    desc "visualize jsp", "visualize jsp"
    def jsp(jsp_path)
      setup

      # 一旦引数はディレクトリと想定
      root_path= Pathname.new jsp_path

      Dir.glob("#{root_path}/**/*.jsp").each do |file|
        file_path = Pathname.new file
        next if file_path.directory?

        resource = Senrigan::Resource::Jsp.new(file_path, root_path)
        resource.parse

        Senrigan.register resource
      end

      Senrigan.generate
    end

    private

    def setup
      Senrigan.setup({
        is_display_edge: options[:"display-edge"] ? true : false,
        rankdir: options[:"vertical"] ? nil : "LR"
      })
    end
  end
end
