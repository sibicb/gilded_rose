class GildedRose
  attr_accessor :item
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      update_sell_in(item)

      case item.name
      when 'Aged Brie'
        item.quality += 1
        validate_quality(item)

      when 'Sulfuras, Hand of Ragnaros'
        item.quality = 80 # ensures Sulfuras is on top quality all the time

      when 'Backstage passes to a TAFKAL80ETC concert'
        item.quality += 1 if item.sell_in > 10
        item.quality += 2 if item.sell_in > 5 && item.sell_in <= 10
        item.quality += 3 if item.sell_in <= 5 && item.sell_in > 0
        validate_quality(item)

      when 'Conjured'
        item.quality -= 2 if item.quality >= 0 && item.sell_in >= 0
        item.quality -= 4 if item.quality >= 0 && item.sell_in < 0
        validate_quality(item)

      else
        sell_in > 0 ? (item.quality -= 1) : (item.quality -= 2)
        validate_quality(item)

      end
      puts "#{item.name}, #{item.sell_in}, #{item.quality}"
    end
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end

  def validate_quality(item)
    item.quality = 50 if item.quality >= 50
    item.quality = 0 if item.quality < 0
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
