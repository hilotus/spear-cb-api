describe Spear do
  before :each do
    Spear.config({dev_key: 'xxx', project: 'ProjectName', using_model: true})
  end

  it "check user existing" do
    s = Spear.check_existing('zhangfei@163.com.cn', '111111111')
    puts s.response
  end

  it "application history" do
    s = Spear.history('XRHR3NV6S8SK6DJ0GKSD')
    puts s.response
  end

  it 'search job' do
    s = Spear.search_job({:TalentNetworkDID => 'TN818G76D6YWYNBXHB3Z', :SiteEntity => 'TalentNetworkJob', :CountryCode => 'IN'})
    puts s.response
  end

  it "retrieve job" do
    s = Spear.retrieve_job('J3J4BP6MGVH2DJZ6MJH')
    puts s.response
  end

  it "create application" do
    s = Spear.create_application('IN', {JobDID: 'xxx', Resume: {ResumeTitle: 'title'}, Responses: [{QuestionID: 'id', ResponseText: 'text'}]})
    puts s.response
  end

  it "tn join form question" do
    s = Spear.join_form_questions('TN818G76D6YWYNBXHB3Z')
    puts s.response
  end

  it "tn create member" do
    s = Spear.create_member({
      TalentNetworkDID: 'TN818G76D6YWYNBXHB3Z',
      PreferredLanguage: 'USEnglish',
      AcceptPrivacy: false,
      AcceptTerms: false,
      ResumeWordDoc: '',
      JoinValues: [
        {Key: 'MxDOTalentNetworkMemberInfo_EmailAddress', Value: 'some.email@example.com'},
        {Key: 'JQ7I3CM6P9B09VCVD9YF', Value: 'AVAILABLENOW'}
      ]
    })
    puts s.response
  end
end
