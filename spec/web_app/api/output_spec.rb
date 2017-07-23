describe 'API' do

  # Creating

  describe 'output saving' do
    it 'creates a new line plot output resource (implicite type)' do
      n = Output.all.length
      post('/api/output/plot',
           {
             :data => @plot_data.to_json,
             :description => 'This is a description.',
           })
      expect(last_response).to be_ok
      expect(Output.all.length).to eq(n + 1)
    end

    it 'creates a new line plot output resource (explicite type)' do
      n = Output.all.length
      post('/api/output/plot',
           {
             :data => @plot_data.to_json,
             :scatter => 'false',
             :description => 'This is a description.',
           })
      expect(last_response).to be_ok
      expect(Output.all.length).to eq(n + 1)
    end

    it 'creates a new scatter plot output resource' do
      n = Output.all.length
      post('/api/output/plot',
           {
             :data => @plot_data.to_json,
             :scatter => true.to_json,
             :description => 'This is a description.',
           })
      expect(last_response).to be_ok
      expect(Output.all.length).to eq(n + 1)
    end

    it 'creates a new diff output resource' do
      n = Output.all.length
      post('/api/output/diff',
           {
             :a => @diff_a,
             :b => @diff_b,
             :description => 'This is a description.',
           })
      expect(last_response).to be_ok
      expect(Output.all.length).to eq(n + 1)
    end

    it 'creates a new text output resource' do
      n = Output.all.length
      post('/api/output/text',
           {
             :text => 'This is some text.',
             :description => 'This is a description.',
           })
      expect(last_response).to be_ok
      expect(Output.all.length).to eq(n + 1)
    end

    it 'creates a new markup output resource' do
      n = Output.all.length
      post('/api/output/markup',
           {
             :data => @markdown,
             :lang => 'md',
             :description => 'This is a description.',
           })
      expect(last_response).to be_ok
      expect(Output.all.length).to eq(n + 1)
    end

    it 'creates a new HTML output resource' do
      n = Output.all.length
      post('/api/output/html',
           {
             :html => @html,
             :description => 'This is a description.',
           })
      expect(last_response).to be_ok
      expect(Output.all.length).to eq(n + 1)
    end

    it 'creates a new SVG output resource' do
      n = Output.all.length
      post('/api/output/svg',
           {
             :svg => @svg,
             :description => 'This is a description.',
           })
      expect(last_response).to be_ok
      expect(Output.all.length).to eq(n + 1)
    end

    it 'creates a new image output resource' do
      n = Output.all.length
      post('/api/output/image',
           {
             :image => Base64.encode64(@image),
             :description => 'This is a description.',
           })
      expect(last_response).to be_ok
      expect(Output.all.length).to eq(n + 1)
    end

    it 'creates a new table output resource (without head - implicite)' do
      n = Output.all.length
      post('/api/output/table',
           {
             :data => @table_data.to_json,
             :description => 'This is a description.',
           })
      expect(last_response).to be_ok
      expect(Output.all.length).to eq(n + 1)
    end

    it 'creates a new table output resource (without head - explicite)' do
      n = Output.all.length
      post('/api/output/table',
           {
             :data => @table_data.to_json,
             :head => 'false',
             :description => 'This is a description.',
           })
      expect(last_response).to be_ok
      expect(Output.all.length).to eq(n + 1)
    end

    it 'creates a new table output resource (with head)' do
      n = Output.all.length
      post('/api/output/table',
           {
             :data => @table_data.to_json,
             :head => 'true',
             :description => 'This is a description.',
           })
      expect(last_response).to be_ok
      expect(Output.all.length).to eq(n + 1)
    end

    it 'creates a new HAML output resource (with head)' do
      n = Output.all.length
      post('/api/output/haml',
           {
             :haml => @haml.to_json,
             :description => 'This is a description.',
           })
      expect(last_response).to be_ok
      expect(Output.all.length).to eq(n + 1)
    end

  end


  # Deleting

  describe 'output deleting' do
    it 'deletes the specified line plot' do
      n = Output.count
      output = Output.order(:datetime).first
      delete('/api/output/' + output.id.to_s)
      expect(Output.count).to eq(n - 1)
    end
  end

end
