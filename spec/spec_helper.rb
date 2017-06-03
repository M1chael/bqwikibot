require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |c|
  c.before(:each) do
    stub_request(:get, 'http://4pda.ru/forum/index.php?act=Stats&t=775878&view=who').
      with(:headers => {'User-Agent'=>'BQ wiki bot'}).
      to_return(File.read('test/U_Lite_commentators.html'))    
    stub_request(:get, 'http://4pda.ru/devdb/bq_aquaris_u_lite').
      with(:headers => {'User-Agent'=>'BQ wiki bot'}).
      to_return(File.read('test/U_Lite_reviews.html'))
  end
end

COMMENTATORS = { 'alex12379' => {count: 293, pct: 18},
  'Marko Bruni' => {count: 109, pct: 7},
  'CrazyNut' => {count: 99, pct: 6},
  'jno' => {count: 97, pct: 6},
  'moovel' => {count: 84, pct: 5}
  }
