require 'rspec'

require File.join(File.dirname(__FILE__), 'gilded_rose')

# Refactoring the code to be not bad
# test coverage??

describe GildedRose do
  it "does not change the name" do
    items = [Item.new("foo", 0, 0)]
    GildedRose.new(items).update_quality()
    expect(items[0].name).to eq "foo"
  end


  context "when the item is 'Aged Brie'" do 
    it "increased the quality" do 
      items = [Item.new("Aged Brie", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 2
    end

    context "and the sell_in is < 0" do 
      it "increased the quality" do 
        items = [Item.new("Aged Brie", -1, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end

      it "reduces the sell_in" do 
        items = [Item.new("Aged Brie", -1, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq (-2)
      end
    end

    context "and the sell_in is < 6" do 
      it "increased the quality" do 
        items = [Item.new("Aged Brie", 4, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end

      it "reduces the sell_in" do 
        items = [Item.new("Aged Brie", 8, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 7
      end
    end

    context "and the sell_in is > 6 but < 11" do 
      it "increased the quality" do 
        items = [Item.new("Aged Brie", 9, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end

      it "reduces the sell_in" do 
        items = [Item.new("Aged Brie", 8, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 7
      end
    end

    context "and the initial quality is > 0" do 
      it "increased the quality" do 
        items = [Item.new("Aged Brie", 0, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end

      it "reduces the sell_in" do 
        items = [Item.new("Aged Brie", 8, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 7
      end
    end

    context "and the initial quality is > 50" do 
      it "does not change the quality" do 
        items = [Item.new("Aged Brie", 0, 51)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 51
      end

      it "reduces the sell_in" do 
        items = [Item.new("Aged Brie", 8, 51)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 7
      end
    end
  end

  describe "when the item is 'Backstage passes to a TAFKAL80ETC concert'" do 
    let(:concert_tickets){"Backstage passes to a TAFKAL80ETC concert"}

    it "quality stays the same" do 
      items = [Item.new(concert_tickets, 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    context "and the initial quality is > 0" do 
      it "iquality becomes 0" do 
        items = [Item.new(concert_tickets, 0, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "and the initial quality is > 50" do 
      it "quality becomes 0" do 
        items = [Item.new(concert_tickets, 0, 51)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "and the sell in is < 0" do 
      it "quality becomes 0" do 
        items = [Item.new(concert_tickets, -1, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "and the sell in is < 6" do 
      it "increased the quality" do 
        items = [Item.new(concert_tickets, 4, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end
    end

    context "and the sell in is > 6 but < 11" do 
      it "increased the quality" do 
        items = [Item.new(concert_tickets, 9, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end
    end

    context "and the sell in is > 11" do 
      it "increased the quality" do 
        items = [Item.new(concert_tickets, 12, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end
    end
  end

  describe "when the item is 'Sulfuras, Hand of Ragnaros'" do 
    let(:the_hand){"Sulfuras, Hand of Ragnaros"}

    it "quality stays the same" do 
      items = [Item.new(the_hand, 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    context "and the sell in is < 0" do 
      it "quality stays the same" do 
        items = [Item.new(the_hand, -1, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "and the sell in is < 6" do 
      it "quality stays the same" do 
        items = [Item.new(the_hand, 4, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "and the sell in is > 6 but < 11" do 
      it "does not change the quality" do 
        items = [Item.new(the_hand, 9, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "and the initial quality is > 0" do 
      it "does not change the quality" do 
        items = [Item.new(the_hand, 0, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end
    end

    context "and the initial quality is > 50" do 
      it "does not change the quality" do 
        items = [Item.new(the_hand, 0, 51)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 51
      end
    end
  end

  describe "when the item is 'foo'" do 
  let(:item_name){ "foo" }
    it "quality stays the same" do 
      items = [Item.new(item_name, 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    context "and the sell in is < 0" do 
      it "quality stays the same" do 
        items = [Item.new(item_name, -1, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "and the sell in is < 6" do 
      it "quality stays the same" do 
        items = [Item.new(item_name, 4, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "and the sell in is > 6 but < 11" do 
      it "does not change the quality" do 
        items = [Item.new(item_name, 9, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "and the initial quality is > 0" do 
      it "reduces the quality " do 
        items = [Item.new(item_name, 0, 8)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 6
      end
    end

    context "and the initial quality is 0" do 
      it "does not change the quality" do 
        items = [Item.new(item_name, 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "and the initial quality is > 50" do 
      it "reduces the quality by 2" do 
        items = [Item.new(item_name, 0, 51)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 49
      end
    end
  end
end
