class GildedRose
  attr_accessor :item
  def initialize(items)
    @items = items
  end

  def update
    @items.each do |item|
      update_sell_in(item)
      update_quality(item)
      info(item)
    end
  end

  def update_quality(item)
    case item.name
    when 'Aged Brie'
      item.quality += 1
    when 'Sulfuras, Hand of Ragnaros'
      item.quality = 80 # ensures Sulfuras is on top quality all the time
    when 'Backstage passes to a TAFKAL80ETC concert'
      item.quality += 1 if item.sell_in > 10
      item.quality += 2 if item.sell_in > 5 && item.sell_in <= 10
      item.quality += 3 if item.sell_in <= 5 && item.sell_in > 0
      item.quality = 0 if item.sell_in == 0
    when 'Conjured'
      item.quality -= 2 if item.quality >= 0 && item.sell_in >= 0
      item.quality -= 4 if item.quality >= 0 && item.sell_in < 0
    else
      item.sell_in > 0 ? (item.quality -= 1) : (item.quality -= 2)
    end
    validate_quality(item)
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end

  def validate_quality(item)
    if item.name != 'Sulfuras, Hand of Ragnaros'
      item.quality = 50 if item.quality >= 50
      item.quality = 0 if item.quality <= 0
    end
  end

  def info(item)
    puts "Name: #{item.name},
    Must be sold in: #{item.sell_in} Days, Quality: #{item.quality}"
  end
end

class Item
  attr_accessor :name, :sell_in, :quality
  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
