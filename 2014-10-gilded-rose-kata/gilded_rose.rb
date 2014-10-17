def update_quality(items)
  items.each do |item|
    ItemWrapper.update(item)
  end
end

class ItemWrapper
  def self.update(item)
    class_for(item).new(item).update
  end

  def self.class_for(item)
    case item.name
    when 'Sulfuras, Hand of Ragnaros'
      Sulfuras
    when "Aged Brie"
      Brie
    when 'Backstage passes to a TAFKAL80ETC concert'
      BackstagePass
    when "Conjured Mana Cake"
      ConjuredItem
    else
      self
    end
  end

  def initialize(item)
    @item = item
  end

  attr_reader :item

  def update_sell_in
    item.sell_in -= 1
  end

  def update_quality
    item.quality -= item.sell_in > 0 ? 1 : 2
  end

  def check_quality
    item.quality = 0 if item.quality < 0
    item.quality = 50 if item.quality > 50
  end

  def update
    update_sell_in
    update_quality
    check_quality
  end
end

class Sulfuras < ItemWrapper
  def update
  end
end

class Brie < ItemWrapper
  def update_quality
    item.quality += item.sell_in > 0 ? 1 : 2
  end
end

class BackstagePass < ItemWrapper
  def update_quality
    if item.sell_in < 0
      item.quality = 0
    elsif item.sell_in < 5
      item.quality += 3
    elsif item.sell_in < 10
      item.quality += 2
    else
      item.quality += 1
    end
  end
end

class ConjuredItem < ItemWrapper
  def update_quality
    item.quality -= item.sell_in > 0 ? 2 : 4
  end
end


# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

