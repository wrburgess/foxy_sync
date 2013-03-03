require 'spec_helper'

describe FoxySync::Xml::TransactionDetail do

  let :document do
    FoxySync::Xml::Document.new XmlHelper::TRANSACTION_DECRYPTED
  end

  let :detail do
    described_class.new document.node.at_xpath('//transaction_detail')
  end


  it 'should return the custom product options in a hash' do
    options = detail.custom_product_options
    expect(options).to be_a Hash

    expected_options = {
      'color' => 'red',
      'Quantity Discount' => '$0.50',
      'Price Discount Amount' => '-5%'
    }

    expect(options.size).to eq expected_options.size
    expected_options.each{|k, v| expect(options[k]).to eq v }
  end


  describe 'getting all details' do
    let(:details) { described_class.all document }

    it 'should have one detail' do
      expect(details.size).to eq 1
      expect(details.first).to be_a described_class
    end

    it 'should have the right product_code' do
      expect(details.first.product_code).to eq 'abc123zzz'
    end

    it 'should have the right product name' do
      expect(details.first.product_name).to eq 'Example Product with Hex and Plus Spaces'
    end

    it 'should have the right product quantity' do
      expect(details.first.product_quantity).to eq '2'
    end
  end

end