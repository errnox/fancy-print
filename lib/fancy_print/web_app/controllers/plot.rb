module FancyPrint
  class App
    def plot_home
      haml :home, :layout => :application
    end

    def generate_html_table(data, head)
      head = head || false
      max_cells = data.collect() { |row| row.length }.max
      html = '<table class="table table-hover table-responsive \
table-bordered table-condensed">'
      data.each_with_index do |row, idx|
        html << '<tr>'
        html << '<thead>' if (idx == 0 && head)
        max_cells.times do |i|
          html << (idx == 0 && head ? '<th>' : '<td>') +
            (CGI.escapeHTML(row[i].to_s) || '&nbsp;') +
            (idx == 0 && head ? '</th>' : '</td>')
        end
        html << '</thead><tbody>' if (idx == 0 && head)
        html << '</tr>'
      end
      html << '</tbody>' if head
      html << '</table>'
    end

    def plot_websocket_info
      begin
        status 200
        settings.websocket.to_json
      rescue
        status 500
        nil
      end
    end

    def protect_from_xss
      raise Exception, 'No XSS-prone output types allowed.' if
        settings.no_xss
    end

    def plot_plot
      begin
        # Limit the size of each parameter.
        params.each do |k, v|
          if k != 'image'
            raise Exception, 'Parameter size exceeds limits.' if v.length >
              3000000
          else
            raise Exception, 'Parameter size exceeds limits.' if v.size >
              6000000
          end
        end

        # Dispatch the parameters.
        if ['scatter', 'line', ''].include?(params[:type])
          # Line + scatter plot
          response = {
            :data => JSON.parse(params[:data]),
            :description => params[:description] || '',
            :time => Time.now || '',
            :type =>
            ['scatter', ''].include?(params[:type]) ? 'scatter' : 'line',
          }
        elsif params[:type] == 'diff'
          # Diff
          diff = Diffy::Diff.new(params[:a], params[:b]).to_s(:html)
          ascii = Diffy::Diff.new(params[:a], params[:b])
          response = {
            # Escapint alternative:
            #
            # :data => CGI.escapeHTML(diff),
            :data => diff,
            :ascii => ascii,
            :description => params[:description] || '',
            :time => Time.now || '',
            :type => 'diff',
          }
        elsif params[:type] == 'text'
          # Text
          prefix = '<span class="text-highlighted">'
          suffix = '</span>'
          # highlights = JSON.parse(params[:highlight]) || []
          if params[:highlight] && params[:highlight].class == Array
            highlights = JSON.parse(params[:highlight])
          else
            highlights = []
          end
          # regexps = JSON.parse(params[:regex]) || []
          if params[:regex] && params[:regex].class == Array
            regexps = JSON.parse(params[:regex])
          else
            regexps = []
          end
          text = params[:text]
          # Replace all strings
          highlights.each do |token|
            text.gsub!(token, prefix + "\\0" + suffix)
          end
          # Replace all RegExps
          regexps.each do |token|
            text.gsub!(Regexp.new(token), prefix + "\\0" + suffix)
          end
          response = {
            :data => CGI.escapeHTML(text),
            :description => params[:description] || '',
            :time => Time.now || '',
            :type => 'text',
          }
        elsif params[:type] == 'markup'
          # Markup
          markup = params[:data]
          lang = params[:lang] || 'md'
          rendered = GitHub::Markup.render('file.' + lang, markup)
          response = {
            :data => rendered,
            :markup => markup,
            :description => params[:description] || '',
            :time => Time.now || '',
            :type => 'markup',
          }
        elsif params[:type] == 'html'
          # HTML
          protect_from_xss()
          response = {
            :data => params[:data],
            :description => params[:description] || '',
            :time => Time.now || '',
            :type => 'html',
          }
        elsif params[:type] == 'svg'
          # SVG
          protect_from_xss()
          response = {
            :data => params[:data],
            :description => params[:description] || '',
            :time => Time.now || '',
            :type => 'svg',
          }
        elsif params[:type] == 'image'
          # Image
          image_type = params[:img_type] || ''
          image_type += 'image/' if image_type != ''
          encoded = ';base64,' + params[:data]
          response = {
            :data => encoded.to_s.force_encoding('ISO-8859-1')
              .encode('UTF-8'),
            :description => params[:description] || '',
            :time => Time.now || '',
            :type => 'image',
          }
        elsif params[:type] == 'table'
          # Table
          if params[:head]
            head = (params[:head] == 'false' ? false : true)
          else
            head = false
          end
          table = generate_html_table(JSON.parse(params[:data]), head)
          response = {
            :data => table,
            :description => params[:description] || '',
            :time => Time.now || '',
            :type => 'table',
          }
        elsif params[:type] == 'haml'
          # Table
          protect_from_xss()
          html = Haml::Engine.new(params[:data]).render
          response = {
            :data => html,
            :description => params[:description] || '',
            :time => Time.now || '',
            :type => 'html',
          }
        end
        status 200
        $channel.push response.to_json
      rescue Exception => exception
        status 500
      end
      nil
    end
  end
end
