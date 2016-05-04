require 'spec_helper'
require_relative '../gilded_rose_refactor.rb'

RSpec.configure do |config|
  config.failure_color = :magenta
  config.tty = true
  config.color = true
end

describe Item do
  context 'stores 5 items in an array variable' do
    let(:list_of_items) do
      [
        Item.new('Aged Brie', 5, 48),
        Item.new('Sulfuras, Hand of Ragnaros', 5, 80),
        Item.new('Backstage passes to a TAFKAL80ETC concert', 12, 1),
        Item.new('Conjured', 10, 20),
        Item.new('Lame Item', 6, 5)
      ]
    end
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
      expect(item.name).to eq 'foo'
    end
  end
  context 'updating' do
    it 'decreases sell_in by 1 each update' do
      item = Item.new('Aged Brie', sell_in = 20, quality = 45)
      item_to_update = [item]
      gilded_rose = GildedRose.new(item_to_update)
      gilded_rose.update
      expect(item.sell_in).to eq sell_in - 1
    end
  end
  context 'Backstage Category' do
    it 'quality increases by 1 if sell_in > 10 days' do
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in = 25, quality = 40)
      item_to_update = [item]
      gilded_rose = GildedRose.new(item_to_update)
      gilded_rose.update
      expect(item.quality).to eq quality + 1
    end
    it 'increases by 2 if sell_in <= 10 days' do
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in = 9, quality = 40)
      item_to_update = [item]
      gilded_rose = GildedRose.new(item_to_update)
      gilded_rose.update
      expect(item.quality).to eq quality + 2
    end
    it 'increases by 3 if sell_in <= 5 days' do
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in = 4, quality = 40)
      item_to_update = [item]
      gilded_rose = GildedRose.new(item_to_update)
      gilded_rose.update
      expect(item.quality).to eq quality + 3
    end
    it 'turns 0 if sell_in == 0' do
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in = 0, quality = 40)
      item_to_update = [item]
      gilded_rose = GildedRose.new(item_to_update)
      gilded_rose.update
      expect(item.quality).to eq 0
    end
  end
  context 'Sulfuras' do
    it 'does not change quality' do
      item = Item.new('Sulfuras, Hand of Ragnaros', sell_in = 5, quality = 40)
      item_to_update = [item]
      gilded_rose = GildedRose.new(item_to_update)
      5.times { gilded_rose.update }
      expect(item.quality).to eq item.quality
    end
  end
  context 'Conjured' do
    it 'decreases quality if sell in is more than or equals 0' do
      item = Item.new('Conjured', sell_in = 5, quality = 40)
      item_to_update = [item]
      gilded_rose = GildedRose.new(item_to_update)
      gilded_rose.update
      expect(item.quality).to eq quality - 2
    end
    it 'doubles decrease in quality if sell in is less than 0' do
      item = Item.new('Conjured', sell_in = -3, quality = 40)
      item_to_update = [item]
      gilded_rose = GildedRose.new(item_to_update)
      gilded_rose.update
      expect(item.quality).to eq quality - 4
    end
  end
  context 'Everything Else' do
    it 'decreases quality if sell_in >= 0' do
      item = Item.new('Lame Item', sell_in = 5, quality = 40)
      item_to_update = [item]
      gilded_rose = GildedRose.new(item_to_update)
      gilded_rose.update
      expect(item.quality).to eq quality - 1
    end
    it 'doubles decrease in quality if sell_in > 0' do
      item = Item.new('Lame Item', sell_in = -1, quality = 40)
      item_to_update = [item]
      gilded_rose = GildedRose.new(item_to_update)
      gilded_rose.update
      expect(item.quality).to eq quality - 2
    end
  end
end
describe ".validate_quality" do
  context 'Item Quality' do
    it 'maxes out at 50' do
      item = Item.new('Aged Brie', sell_in = 8, quality = 46)
      item_to_update = [item]
      gilded_rose = GildedRose.new(item_to_update)
      5.times { gilded_rose.update }
      expect(item.quality).to eq 50
    end
    it 'stops decreasing in quality if 0' do
      item = Item.new('Conjured', sell_in = 8, quality = 8)
      item_to_update = [item]
      gilded_rose = GildedRose.new(item_to_update)
      5.times { gilded_rose.update }
      expect(item.quality).to eq 0
    end
    it 'does not affect if item is sulfuras' do
      item = Item.new('Sulfuras, Hand of Ragnaros', sell_in = 5, quality = 40)
      item_to_update = [item]
      gilded_rose = GildedRose.new(item_to_update)
      5.times { gilded_rose.update }
      expect(item.quality).to eq 80
    end
  end
end
