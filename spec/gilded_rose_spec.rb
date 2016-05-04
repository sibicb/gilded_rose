require 'spec_helper'
require_relative '../gilded_rose_refactor.rb'

RSpec.configure do |config|
  config.failure_color = :magenta
  config.tty = true
  config.color = true
end

describe Item do
  context 'stores 5 items in an array variable' do
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
      expect(list_of_items.is_a?(Array)).to eq(true)
    end
  end
end

describe GildedRose do
  context 'item name' do
    it 'does not change the name' do
      item = Item.new('foo', sell_in = 0, quality = 0)
      items = [item]
      gilded_rose = GildedRose.new(items)
      gilded_rose.update
      expect(item.name).to eq  'foo'
    end
  end
  context 'when item name is Aged Brie' do
    context 'item quality' do
      context 'when sell in date not passed yet' do
        it 'increases by 1 the older it gets' do
          x = 5
          item = Item.new('Aged Brie',sell_in = x, quality = 0)
          items = [item]
          gilded_rose = GildedRose.new(items)
          
          x.times do |i|
            gilded_rose.update
            expect(item.quality).to eq (i + 1)
          end
        end
      end
    end
    context 'when item name is Sulfuras, Hand of Ragnaros' do
      context 'item sell in' do
        it 'does not change the sell in' do
          item = Item.new('Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 0)
          items = [item]
          gilded_rose = GildedRose.new(items)
          gilded_rose.update
          expect(item.sell_in).to eql 0
        end
      end
        context 'item quality' do
        it 'does not change the quality' do
          item = Item.new('Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 0)
          items = [item]
          gilded_rose = GildedRose.new(items)
          gilded_rose.update
          expect(item.quality).to eql 80
        end
      end
    end
  end
end
