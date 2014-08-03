module Senrigan
  module Resource
    class Jsp
      class DirectoryGivenError < StandardError; end

      def initialize(file_path, is_override: true)
        # directoryの場合、エラー
        raise DirectoryGivenError.new('error! directory given!') if file_path.directory?
        # TODO: 拡張子がjspでなければ、エラー
        @file_path = file_path
        @is_override = is_override
      end

      def name
        @name ||= @file_path.realpath.to_s
      end

      def label
        name
      end

      def options
        {
          label: label,
          color: "black"
        }
      end

      def next_resources
        @next_resrouces ||= {}
      end

      def override?
        @is_override
      end

      def parse
        content.scan %r!<%@.*include.*file="(.+?)"! do |match|
          # TODO: インクルードが絶対パスで書かれている時

          # 絶対パス化する前のパス
          match_path_origin = Pathname.new(match.first)

          # 絶対パス化
          match_path = base_dir + match_path_origin

          if match_path.exist?
            # overrideはfalse
            next_resources[match_path_origin.to_s] = Jsp.new(match_path, is_override: false)
          else
            # TODO: インクルード先が存在しない時
            puts "ignore because file not exist: #{match_path}"
          end
        end
      rescue Exception => ex
        puts ex.message
        raise ex
      end

      private

      def base_dir
        @file_path.dirname
      end

      def content
        @content ||= @file_path.read
      end
    end
  end
end
