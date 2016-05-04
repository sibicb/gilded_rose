require 'spec_helper'
require_relative '../gilded_rose.rb'

RSpec.configure do |config|
  config.failure_color = :magenta
  config.tty = true
  config.color = true
end

describe Item do
  context 'stores 5 items in the array variable' do
    let(:list_of_items) { [
        Item.new("Aged Brie", 5, 48),
        Item.new("Sulfuras, Hand of Ragnaros", 5, 80),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 12, 1),
        Item.new("Conjured", 10, 20),
        Item.new("Lame Item", 6, 5)
    ] }
    it 'returns count 5' do
      expect(list_of_items.count).to eq(5)
    end
    it 'is an array object' do
      expect(list_of_items.kind_of?(Array)).to eq(true)
    end
  end
end
