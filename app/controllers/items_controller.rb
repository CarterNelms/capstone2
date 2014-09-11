class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def for_rent
    @items = items_of_list_type(:library)
  end

  def search
    @results = api(:title => "The Elder Scrolls V: Skyrim")
  end

  private

  def items_of_list_type(type)
    ItemList.where("type = ?", type).reduce([]){ |items, current_library| items.concat(current_library.items) }
  end

  def api(parameters)
    # These code snippets use an open-source library. http://unirest.io/ruby
    Unirest.post("https://byroredux-metacritic.p.mashape.com/search/game",
             headers:{'X-Mashape-Key' => "P4tmxj1VOvmshEjU6SkDZPPegQpbp1PgT6CjsnMggmVWvrbRvA"},
             parameters: parameters.merge(:retry => 4)
             ).body["results"]
  end
end
