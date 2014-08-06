module Senrigan
  module Resource
    class Jsp
      class DirectoryGivenError < StandardError; end

      attr_reader :file_path, :root_path

      def initialize(file_path, root_path, is_override: true)
        # directoryの場合、エラー
        raise DirectoryGivenError.new('error! directory given!') if file_path.directory?
        # TODO: 拡張子がjspでなければ、エラー
        @file_path = file_path
        @root_path = root_path
        @is_override = is_override
      end

      def name
        @name ||= file_path.realpath.to_s
      end

      def label
        file_path.realpath.relative_path_from(root_path.realpath)
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
        # TODO: インクルードが絶対パスで書かれている時
        regs = [
          %r!<%@.*include.*file="(.+?)"!,
          %r!<jsp:include page="(.+?)"!
        ]

        regs.each do |reg|
          content.scan reg do |match|
            set_next_resources(match.first)
          end
        end
      rescue Exception => ex
        puts ex.message
        raise ex
      end

      private

      def set_next_resources match_string
        # 絶対パス化する前のパス
        match_path_origin = Pathname.new(match_string)

        # 絶対パス化
        match_path = base_dir + match_path_origin

        if match_path.exist?
          # overrideはfalse
          next_resources[match_path_origin.to_s] = Jsp.new(match_path, root_path, is_override: false)
        else
          # TODO: インクルード先が存在しない時
          puts "ignored: because file not exist: #{match_path}"
        end
      end

      def base_dir
        file_path.dirname
      end

      def content
        @content ||= file_path.read
      end
    end
  end
end
