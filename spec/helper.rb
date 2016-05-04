module Helpers
  attr_accessor :item, :items, :gilded_rose, :sell_in
  def name_helper(name, sell_in = 0, quality = 0)
    item = Item.new(name, sell_in, quality)
    items = [item]
    gilded_rose = GildedRose.new(items)
    gilded_rose.update_item
    return item.name
  end

  def quality_helper(name, sell_in = 0, quality = 0, n = 0)
    item = Item.new(name, sell_in, quality)
    items = [item]
    gilded_rose = GildedRose.new(items)
    n == 0 ? gilded_rose.update_item : n.times { gilded_rose.update_item }
    return item.quality
  end

  def sell_in_helper(name, sell_in = 0, quality = 0)
    item = Item.new(name, sell_in, quality)
    items = [item]
    gilded_rose = GildedRose.new(items)
    gilded_rose.update_item
    return item.sell_in
  end

end
