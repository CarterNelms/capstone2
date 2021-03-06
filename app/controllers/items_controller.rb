class ItemsController < ApplicationController

  def index
    @search = Item.search(params[:q])
    # @items = @search.result
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
  end

  def search
    @search = Item.search(params[:q])
    @items = @search.result
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
    render partial: "listings", layout: false
  end

  def for_rent
    @items = items_of_list_type(:Library)
  end

  def wanted
    @items = items_of_list_type(:WantedList)
  end

  def titles
    @input = params["titles"] || {}
  end

  def get_titles
    @results = {}
    @input = params["titles"] || {}
    if !@input.empty?
      keywords = @input[:keywords].gsub(/[^a-zA-Z0-9\s]/, '')
      if keywords.length > 0
        Item.type_symbols_plural.each do |s|
          @results[s] = send("#{s.to_s}_api", keywords) if @input[s] == "1"
        end
      end
    end
    render partial: "/items/title_results/index", layout: false
  end

  def from_title
    if params[:library]
      redirect_to new_item_path(params)
    elsif params[:wanted_list]
      redirect_to items_new_wanted_path(params)
    else 
      redirect_to titles_path
    end
  end

  def new
  end

  def new_wanted
  end

  def create
    if current_user
      item_params = params["item"].except("type", "wanted").to_h
      model = params["item"]["type"].gsub(' ', '').constantize
      is_wanted = params["item"]["wanted"] == "true"

      item = model.create(item_params)
      # params["item"]["images"].each do |i|
      #   item.images = i
      # end

      method_name = "add_to_#{is_wanted ? 'wanted_list' : 'library'}"
      if current_user.send(method_name, item)
        flash.notice = "#{item.name} (#{item.proper_class_name}) has successfully been added to your #{is_wanted ? 'list of wanted items' : 'library'}."
        # redirect_to is_wanted ? user_wanted_lists_path(current_user) : user_libraries_path(current_user)
        redirect_to user_path(current_user)
      else
        flash.alert = "Item could not be created"
        redirect_to new_item_path
      end
    else
      flash.alert = "You must be signed in to do that"
      redirect_to new_user_session_path 
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    attributes = params[:item].select{ |key, p| !p.blank? }.permit(:name)

    Item.update(params[:id], attributes)

    redirect_to user_path(current_user)
  end

  def destroy
    Item.destroy(params[:id])
    redirect_to user_path(current_user)
  end

  private

  def items_of_list_type(type)
    ItemList.where("type = ?", type).reduce([]){ |items, current_library| items.concat(current_library.items) }
  end

  def books_api(keywords)
    Unirest.get("https://www.googleapis.com/books/v1/volumes?key=#{ENV["books_key"]}&q=#{keywords}",).body["items"]
  end

  def movies_api(keywords)
    Unirest.get("http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=#{ENV["movies_key"]}&q=#{keywords}",).body["movies"]
  end

  def video_games_api(keywords)
    Unirest.get("http://www.giantbomb.com/api/search/?api_key=#{ENV["video_games_key"]}&format=json&query=#{keywords}&resources=game").body["results"]
  end
end
