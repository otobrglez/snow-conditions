require "spec_helper"

require "show"
require "pry"

describe Snow do

  context "parsing error" do

    before do
      WebMock.stub_request(:get, "http://www.arso.gov.si/vreme/napovedi%20in%20podatki/snegraz.html").
        to_return lambda { |request| File.new("./spec/requests/snegraz_error.html") }
    end

    it do
      expect { subject.class.state }.to raise_error Snow::ParsingError
    end

  end

  context "#state" do

    before do
      WebMock.stub_request(:get, "http://www.arso.gov.si/vreme/napovedi%20in%20podatki/snegraz.html").
        to_return lambda { |request| File.new("./spec/requests/snegraz_ok.html") }
    end

    it do
      expect { subject.class.state }.not_to raise_error
    end

    it "should calculate #sha" do
      Snow.state.sha.size.should eq 40
    end

    it { Snow.state.sha.should be_kind_of(String) }
    it { Snow.state.date.should be_kind_of(Date) }
  end

end

