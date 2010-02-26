require File.dirname(__FILE__) + "/../spec_helper"

describe Braintree::Address do
  describe "==" do
    it "returns true if given an address with the same id and customer_id" do
      first = Braintree::Address._new(:customer_id => "c1", :id => 'a1')
      second = Braintree::Address._new(:customer_id => "c1", :id => "a1")

      first.should == second
      second.should == first
    end

    it "returns false if given an address with a different id and the same customer_id" do
      first = Braintree::Address._new(:customer_id => "c1", :id => "a1")
      second = Braintree::Address._new(:customer_id => "c1", :id => "not a1")

      first.should_not == second
      second.should_not == first
    end

    it "returns false if given an address with a different customer_id and the same id" do
      first = Braintree::Address._new(:customer_id => "c1", :id => "a1")
      second = Braintree::Address._new(:customer_id => "not c1", :id => "a1")

      first.should_not == second
      second.should_not == first
    end

    it "returns false when not given an address" do
      address = Braintree::Address._new(:id => "a1")
      address.should_not == "not an address"
    end
  end

  describe "self.create" do
    it "raises an ArgumentError if not given a :customer_id" do
      expect do
        Braintree::Address.create({})
      end.to raise_error(ArgumentError, "Expected hash to contain a :customer_id")
    end

    it "raises if customer id contains invalid chars" do
      expect do
        Braintree::Address.create(:customer_id => "invalid@chars")
      end.to raise_error(ArgumentError, ":customer_id contains invalid characters")
    end

    it "raises an exception if hash includes an invalid key" do
      expect do
        Braintree::Address.create(:street_address => "123 E Main St", :invalid_key => "foo")
      end.to raise_error(ArgumentError, "invalid keys: invalid_key")
    end
  end

  describe "self.update" do
    it "raises an exception if hash includes an invalid key" do
      expect do
        Braintree::Address.update("customer_id", "address_id", :street_address => "456 E Main", :invalid_key => "foo")
      end.to raise_error(ArgumentError, "invalid keys: invalid_key")
    end
  end

  describe "self.find" do
    it "raises an error if customer_id contains invalid chars" do
      expect do
        Braintree::Address.find("spaces not allowed", "address_id")
      end.to raise_error(ArgumentError, "customer_id contains invalid characters")
    end
  end

  describe "self.new" do
    it "is protected" do
      expect do
        Braintree::Address.new
      end.to raise_error(NoMethodError, /protected method .new/)
    end
  end

  describe "update" do
    it "raises an exception if hash includes an invalid key" do
      expect do
        Braintree::Address._new({}).update(:street_address => "456 E Main", :invalid_key2 => "foo")
      end.to raise_error(ArgumentError, "invalid keys: invalid_key2")
    end
  end
end
