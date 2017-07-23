module FancyPrint
  class App

    # Creating

    # Line + scatter plot
    def output_plot_create
      begin
        datetime = Time.now
        scatter = false
        if params.has_key?('scatter')
          scatter = true if params['scatter'].strip == 'true'
        end
        data = {:data => JSON.parse(params['data']), :scatter => scatter}
          .to_json
        type = 'plot'
        description = params['description'] || nil
        save_output(data, type, datetime, description)
      rescue Exception => exception
        status 500
      end
      nil
    end

    # Diff
    def output_diff_create
      begin
        datetime = Time.now
        a = params['a'].to_s
        b = params['b'].to_s
        data = {:a => a, :b => b}.to_json
        type = 'diff'
        description = params['description'] || nil
        save_output(data, type, datetime, description)
      rescue Exception => exception
        status 500
      end
      nil
    end

    # Text
    def output_text_create
      begin
        datetime = Time.now
        data = params['text']
        type = 'text'
        description = params['description'] || nil
        save_output(data, type, datetime, description)
      rescue Exception => exception
        status 500
      end
      nil
    end

    # Markup
    def output_markup_create
      begin
        datetime = Time.now
        data = {:data => params['data'], :lang => params['lang'] || 'md'}
          .to_json
        type = 'markup'
        description = params['description'] || nil
        save_output(data, type, datetime, description)
      rescue Exception => exception
        status 500
      end
      nil
    end

    # HTML
    def output_html_create
      begin
        datetime = Time.now
        data = params['html']
        type = 'html'
        description = params['description'] || nil
        save_output(data, type, datetime, description)
      rescue Exception => exception
        status 500
      end
      nil
    end

    # SVG
    def output_svg_create
      begin
        datetime = Time.now
        data = params['svg']
        type = 'svg'
        description = params['description'] || nil
        save_output(data, type, datetime, description)
      rescue Exception => exception
        status 500
      end
      nil
    end

    # Image
    def output_image_create
      begin
        datetime = Time.now
        data = params['image']
        type = 'image'
        description = params['description'] || nil
        save_output(data, type, datetime, description)
      rescue Exception => exception
        status 500
      end
      nil
    end

    # Table
    def output_table_create
      begin
        datetime = Time.now
        head = false
        if params.has_key?('head')
          head = true if params['head'].strip == 'true'
        end
        data = {
          :data => JSON.parse(params['data']),
          :head => head,
        }.to_json
        type = 'table'
        description = params['description'] || nil
        save_output(data, type, datetime, description)
      rescue Exception => exception
        status 500
      end
      nil
    end

    # HAML
    def output_haml_create
      begin
        datetime = Time.now
        head = false
        data = params['haml']
        type = 'haml'
        description = params['description'] || nil
        save_output(data, type, datetime, description)
      rescue Exception => exception
        status 500
      end
      nil
    end

    # Deleting

    def output_delete
      begin
        Output.delete(Output.where(:id => params['id']))
      rescue Exception => e
        status 500
      end
      nil
    end


    # Listing

    def output_all
      count = Offset.count
      limit = params['limit'].to_i || 10
      offset = params['offset'].to_i || 0

      limit = nil if limit > 200 && limit <= 0
      offset = 0 if !(offset > 0 && offset < 9999 && offset < count)

      prev = (offset > 0 ? offset - 1 : nil)
      nxt = (offset < count ? offset + 1 : nil)

      begin
        outputs = Output.limit(limit).offset(offset)
        response = {
          'previous' => prev,
          'next' => nxt,
          'offset' => offset,
          'limit' => limit,
          'data' => outputs,
        }
        response.to_json
      rescue Exception => e
        status 500
      end
    end

  end
end
