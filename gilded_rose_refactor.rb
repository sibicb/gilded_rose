class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        item.quality = 50 if item.quality > 50
        item.quality += 1 if item.sell_in > 0
        item.sell_in -= 1

      when 'Sulfuras, Hand of Ragnaros'
        item.quality = 80

      when 'Backstage passes to a TAFKAL80ETC concert'
        item.quality = 50 if item.quality > 50
        item.quality += 1 if item.sell_in > 10
        item.quality += 2 if item.sell_in > 5 && item.sell_in < 10
        item.quality += 3 if item.sell_in <= 5 && item.sell_in > 0
        item.quality = 0 if item.sell_in == 0
        item.sell_in -= 1

      when 'Conjured'
        item.quality = 50 if item.quality > 50
        item.quality -= 2 if item.quality >= 0 && item.sell_in >= 0
        item.quality -= 4 if item.quality >= 0 && item.sell_in < 0
        item.quality = 0 if item.quality < 0
        item.sell_in -= 1

      else
      	item.quality = 50 if item.quality > 50
      	sell_in > 0 ? item.quality -= 1 : item.quality -= 2
      	item.quality = 0 if item.quality < 0
      end
    puts "#{item.name}, #{item.sell_in}, #{item.quality}"
    end
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
