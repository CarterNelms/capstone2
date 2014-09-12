class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def for_rent
    @items = items_of_list_type(:Library)
  end

  def search
    @results = api(:title => "The Elder Scrolls V: Skyrim")
  end

  def new_wanted
  end

  def create
    # item_params = params["item"].merge(item_list_id: current_user.library.id).except("type").to_h
    item_params = params["item"].except(["type", "wanted"]).to_h
    model = params["item"]["type"].gsub(' ', '').constantize

    item = model.create(item_params)
    method_name = "add_to_#{params['item']['wanted'] ? 'wanted_list' : 'library'}"
    if current_user.send(method_name, item)
      flash.notice = "#{item.name} (#{item.proper_class_name}) has successfully been added to your library."
      redirect_to user_libraries_path(current_user)
    else
      flash.alert = "Item could not be created"
      redirect_to new_item_path
    end
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
