describe Spear do
  before :each do
    Spear.config({dev_key: ENV['DEVELOPMENT_KEY'], project: 'ExampleApp', use_model: true})
  end

  it "check user existing" do
    res = Spear.check_existing('zhangfei@163.com.cn', 'Qwer12341!')
    puts res.response
  end

  it "application history" do
    res = Spear.history('J3H0YY6LLK553R3Z32Z')
    puts res.response
  end

  it 'search job' do
    res = Spear.search_job({:TalentNetworkDID => 'TN818G76D6YWYNBXHB3Z', :SiteEntity => 'TalentNetworkJob', :CountryCode => 'IN'})
    puts res.response
  end

  it "retrieve job" do
    res = Spear.retrieve_job('J3H0YY6LLK553R3Z32Z')
    puts res.response
  end

  it "create application" do
    res = Spear.create_application('IN', {JobDID: 'xxx', Resume: {ResumeTitle: 'title'}, Responses: [{QuestionID: 'id', ResponseText: 'text'}]})
    puts res.response
  end

  it "tn join form question" do
    res = Spear.join_form_questions('TN818G76D6YWYNBXHB3Z')
    puts res.response
  end

  it "tn create member" do
    res = Spear.create_member({
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
    puts res.response
  end

  it "get application status" do
    # res = Spear.application_status(['JAWS4L16LFXD7ZL87LLC', 'JAWW63876DWNQGSWZ384', 'JA4M44C77CDSR0QHTRJ6'])
    res = Spear.application_status('J3H0YY6LLK553R3Z32Z', 'zhangfei@sina.com.cn')
    puts res.response
  end

  it "get application blank" do
    res = Spear.application_blank('J3H0YY6LLK553R3Z32Z')
    puts res.response
  end

  it "application submit" do
    res = Spear.application_submit('J3H0YY6LLK553R3Z32Z', [
      {QuestionID: 'ApplicantName', ResponseText: 'Zhangfei'},
      {QuestionID: 'ApplicantEmail', ResponseText: 'zhangfei@sina.com.cn'},
      {QuestionID: 'Resume', ResponseText: 'test resume'}
    ], true)
    puts res.response
  end

  it "token authenicate" do
    res = Spear.token_authenticate('XRHT30S64S90Y384P9C7')
    puts res.response
  end
end
