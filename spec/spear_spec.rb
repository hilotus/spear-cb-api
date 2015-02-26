describe Spear do
  before :each do
    Spear.config({dev_key: 'xxx', :project => 'ProjectName', :using_model => true})
  end

  it "check user existing" do
    s = Spear.check_existing('zhangfei@163.com.cn', '111111111')
    puts s
  end

  it "application history" do
    s = Spear.history('XRHR3NV6S8SK6DJ0GKSD')
    puts s
  end

  it 'search job' do
    s = Spear.search_job({:TalentNetworkDID => 'TN818G76D6YWYNBXHB3Z', :SiteEntity => 'TalentNetworkJob', :CountryCode => 'IN'})
    puts s.jobs.last.posted_date
  end

  it "retrieve job" do
    s = Spear.retrieve_job('J3J4BP6MGVH2DJZ6MJH', 'IN')
    puts s
  end

  it "create application" do
    s = Spear.create_application('IN')
    puts s
  end
end
