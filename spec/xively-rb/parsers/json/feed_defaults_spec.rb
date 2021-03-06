require 'spec_helper'

describe "default feed json parser" do
  describe "json" do
    it "should convert Pachube JSON 1.0.0 (used by API v2) into attributes hash" do
      json = feed_as_(:json)
      feed = Xively::Feed.new(json)
      feed.should fully_represent_feed(:json, json)
    end

    it "should convert Pachube JSON 0.6-alpha (used by API v1) into attributes hash" do
      json = feed_as_(:json, :version => "0.6-alpha")
      feed = Xively::Feed.new(json)
      feed.should fully_represent_feed(:json, json)
    end

    it "should convert Pachube JSON 0.6-alpha (used by API v1) into attributes hash" do
      json = feed_as_(:json, :version => "0.6")
      feed = Xively::Feed.new(json)
      feed.should fully_represent_feed(:json, json)
    end

    it "should handle json if no value present" do
      json = "{\"version\":\"0.6-alpha\",\"datastreams\":[{\"unit\":{\"label\":\"Tmax\",\"symbol\":\"C\"},\"values\":{},\"id\":\"1\"}]}"
      expect {
        feed = Xively::Feed.new(json)
        feed.datastreams.size.should == 1
      }.to_not raise_error
    end

    it "should capture empty fields if present" do
      json = "{\"version\":\"1.0.0\",\"description\":\"\",\"feed\":\"\",\"location\":{\"name\":\"\"},\"tags\":[],\"datastreams\":[{\"unit\":{\"label\":\"\",\"symbol\":\"\"},\"tags\":[]}]}"
      feed = Xively::Feed.new(json)
      feed.description.should == ""
      feed.feed.should == ""
      feed.location_name.should == ""
      feed.tags.should == ""
      feed.datastreams.size.should == 1
      feed.datastreams[0].unit_label.should == ""
      feed.datastreams[0].unit_symbol.should == ""
      feed.datastreams[0].tags.should == ""
    end

    it "should throw an error if datastreams is not an array" do
      json = "{\"version\":\"1.0.0\",\"datastreams\":\"foobar\"}"
      expect {
        Xively::Feed.new(json)
      }.should raise_error(Xively::Parsers::JSON::InvalidJSONError, "\"datastreams\" must be an array")
    end
  end
end

