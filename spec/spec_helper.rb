require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |c|
  c.before(:each) do
    stub_request(:get, 'http://4pda.ru/forum/index.php?act=Stats&t=775878&view=who').
      with(:headers => {'User-Agent'=>'BQ wiki bot'}).
      to_return(File.read('test/U_Lite_commentators.html'))
  end
end
