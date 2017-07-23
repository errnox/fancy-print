describe 'Info about the application' do
  it 'gets the client info' do
    get '/info/doc/client'
    expect(last_response).to be_ok
  end

  it 'gets the api info' do
    get '/info/doc/api'
    expect(last_response).to be_ok
  end

  it 'gets the cli info' do
    get '/info/doc/cli'
    expect(last_response).to be_ok
  end
end
