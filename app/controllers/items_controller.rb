class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def for_rent
    @items = items_of_list_type(:Library)
  end

  def wanted
    @items = items_of_list_type(:WantedList)
  end

  def search
    @results = api(:title => "The Elder Scrolls V: Skyrim")
  end

  def new_wanted
  end

  def create
    if current_user
      item_params = params["item"].except("type", "wanted").to_h
      model = params["item"]["type"].gsub(' ', '').constantize
      is_wanted = params["item"]["wanted"] == "true"

      item = model.create(item_params)
      method_name = "add_to_#{is_wanted ? 'wanted_list' : 'library'}"
      if current_user.send(method_name, item)
        flash.notice = "#{item.name} (#{item.proper_class_name}) has successfully been added to your #{is_wanted ? 'list of wanted items' : 'library'}."
        redirect_to is_wanted ? user_wanted_lists_path(current_user) : user_libraries_path(current_user)
      else
        flash.alert = "Item could not be created"
        redirect_to new_item_path
      end
    else
      flash.alert = "You must be signed in to do that"
      redirect_to new_user_session_path 
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
