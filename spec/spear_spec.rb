describe Spear do
  before :each do
    Spear.config({dev_key: ENV['DEVELOPMENT_KEY'], project: 'ExampleApp', use_model: true})
  end

  it "check user existing" do
    s = Spear.check_existing('zhangfei@163.com.cn', '111111111')
    puts s.response
  end

  it "application history" do
    s = Spear.history('J3H0YY6LLK553R3Z32Z')
    puts s.response
  end

  it 'search job' do
    s = Spear.search_job({:TalentNetworkDID => 'TN818G76D6YWYNBXHB3Z', :SiteEntity => 'TalentNetworkJob', :CountryCode => 'IN'})
    puts s.response
  end

  it "retrieve job" do
    s = Spear.retrieve_job('J3H0YY6LLK553R3Z32Z')
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

  it "get application status" do
    # s = Spear.application_status(['JAWS4L16LFXD7ZL87LLC', 'JAWW63876DWNQGSWZ384', 'JA4M44C77CDSR0QHTRJ6'])
    s = Spear.application_status('J3H0YY6LLK553R3Z32Z', 'zhangfei@sina.com.cn')
    puts s.response
  end

  it "get application blank" do
    s = Spear.application_blank('J3H0YY6LLK553R3Z32Z')
    puts s.response
  end

  it "application submit" do
    s = Spear.application_submit('J3H0YY6LLK553R3Z32Z', [
      {QuestionID: 'ApplicantName', ResponseText: 'Zhangfei'},
      {QuestionID: 'ApplicantEmail', ResponseText: 'zhangfei@sina.com.cn'},
      {QuestionID: 'Resume', ResponseText: 'test resume'}
    ])
    puts s.response
  end
end
