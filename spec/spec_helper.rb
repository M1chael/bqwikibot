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

COMMENTATORS = [ {name: 'alex12379', count: 532, pct: 13},
  {name: 'jno', count: 263, pct: 7},
  {name: 'moovel', count: 182, pct: 5},
  {name: 'vova0302', count: 177, pct: 4},
  {name: 'bobrovilya', count: 147, pct: 4}
  ]
