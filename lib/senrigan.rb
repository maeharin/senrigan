require "senrigan/version"
require "senrigan/resource"

require 'graphviz'

module Senrigan
  class << self
    attr_reader :options

    def setup(args = {})
      @options = default_options.merge(args)
      @graph = GraphViz.new( :G, type: options[:type], rankdir: options[:rankdir] )
    end

    def default_options
      {
        output_path: File.expand_path('./images/output.gif'),
        is_display_edge: false,
        type: :digraph,
        rankdir: "LR"
      }
    end

    # 画像を生成する
    def generate
      @graph.output( gif: options[:output_path] )
    end

    # resourceをgraphvizのグラフに登録する
    def register(resource)
      # resourceをグラフに登録
      g_resource_node = add_resource_to_graph resource

      # 続くアクションを登録
      resource.next_resources.each do |edge_label, next_resource|
        # next_resourceをグラフに登録
        g_next_resource_node = add_resource_to_graph next_resource

        # resource -> next_resourceのエッジを登録
        if g_next_resource_node
          edge_label = options[:is_display_edge] ? edge_label : ''
          add_edge_to_graph g_resource_node, g_next_resource_node, edge_label 
        end
      end
    end

    private

    def add_resource_to_graph(resource)
      ## overrideの場合、そのまま登録
      if resource.override?
        return @graph.add_node(resource.name, resource.options)
      end

      # overrideでない場合、そのまま突っ込むと既に登録済みのノード情報を
      # 上書きしてしまう可能性がある(ラベル情報を書き消してしまう）
      # なので、同名のノードが既にグラフに登録されているかどうかを見て、
      # 既に登録されていれば、それを使うようにする
      if @graph.get_node(resource.name)
        return @graph.get_node(resource.name)
      else
        return @graph.add_node(resource.name, resource.options)
      end
    end

    def add_edge_to_graph(node, other_node, label)
      edge = @graph.add_edges(node, other_node)
      edge[:label] = label
    end
  end
end
