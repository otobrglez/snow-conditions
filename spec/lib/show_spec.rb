require "spec_helper"

describe Snow do

  context "parsing error" do

    before do
      WebMock.stub_request(:get, "http://www.arso.gov.si/vreme/napovedi%20in%20podatki/snegraz.html").
        to_return lambda { |request| File.new("./spec/requests/snegraz_error.html") }
    end

    it { expect { subject.class.state }.to raise_error Snow::ParsingError }
  end

  context "#state" do

    before do
      WebMock.stub_request(:get, "http://www.arso.gov.si/vreme/napovedi%20in%20podatki/snegraz.html").
        to_return lambda { |request| File.new("./spec/requests/snegraz_ok.html") }
    end

    it { expect { subject.class.state }.not_to raise_error }
    it { Snow.state.sha.size.should eq 40 }
    it { Snow.state.sha.should be_kind_of(String) }
    it { Snow.state.date.should be_kind_of(Date) }
  end

  context "#process" do
    before do
      WebMock.stub_request(:get, "http://www.arso.gov.si/vreme/napovedi%20in%20podatki/snegraz.html").
        to_return lambda { |request| File.new("./spec/requests/snegraz_ok.html") }
    end

    subject { Snow }

    it "should process" do
      (process = subject.process).should be_kind_of(SnowInformation)
      subject.redis.del(process.key).should eq 1
    end
  end

end

