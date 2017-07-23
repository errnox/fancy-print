module FancyPrint
  class App

    # Home
    gget '/' => :plot_home, :as => :home_path, :mask => '/'

    # Plotting
    ppost %r{/plot/?} => :plot_plot, :as => :plot_path, :mask => '/plot'

    # WebSocket
    gget %r{/websocket/info/?} => :plot_websocket_info, :as =>
      :websocket_info_path, :mask => '/websocket/info'

    # Info
    gget %r{/info/doc/client/?} => :info_client_info, :as =>
      :client_info_path, :mask => '/info/doc/client'
    gget %r{/info/doc/api/?} => :info_api_info, :as =>
      :client_api_path, :mask => '/info/doc/api'
    gget %r{/info/doc/cli/?} => :info_cli_info, :as =>
      :client_cli_path, :mask => '/info/doc/cli'

    # Output API
    nnamespace '/api' do
      # Creating

      # Scatter + line plot
      ppost %r{/output/plot/?} => :output_plot_create, :as =>
        :output_plot_create_path, :mask => '/output/plot'
      # Diff
      ppost %r{/output/diff/?} => :output_diff_create, :as =>
        :output_diff_create_path, :mask => '/output/diff'
      # Text
      ppost %r{/output/text/?} => :output_text_create, :as =>
        :output_text_create_path, :mask => '/output/text'
      # Markup
      ppost %r{/output/markup/?} => :output_markup_create, :as =>
        :output_markup_create_path, :mask => '/output/markup'
      # HTML
      ppost %r{/output/html/?} => :output_html_create, :as =>
        :output_html_create_path, :mask => '/output/html'
      # SVG
      ppost %r{/output/svg/?} => :output_svg_create, :as =>
        :output_svg_create_path, :mask => '/output/svg'
      # Image
      ppost %r{/output/image/?} => :output_image_create, :as =>
        :output_image_create_path, :mask => '/output/image'
      # Table
      ppost %r{/output/table/?} => :output_table_create, :as =>
        :output_table_create_path, :mask => '/output/table'
      # HAML
      ppost %r{/output/haml/?} => :output_haml_create, :as =>
        :output_haml_create_path, :mask => '/output/haml'

      # Deleting

      # This covers all output types (`plot', `text', `diff', `html', ...)
      ddelete %r{/output/:id/?} => :output_delete, :as =>
        :output_delete_path, :mask => '/output'

      # Listing

      gget %r{/outputs/?} => :output_all, :as => :output_all, :mask =>
        '/outputs'
    end

  end
end
