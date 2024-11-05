class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
  def insert
    act = Actor.new
    act.name = params.fetch("query_name")
    act.dob = params.fetch("query_dob")
    act.bio = params.fetch("query_bio")
    act.image = params.fetch("query_image")
    act.id = rand(1000..100000)
    act.save
    redirect_to("/actors")
  end
  def delete
    Actor.destroy(params.fetch("id"))
    redirect_to("/actors")
  end
  def modify
    id = params.fetch("id")
    act = Actor.where({:id => id})[0]
    act.name = params.fetch("query_name")
    act.dob = params.fetch("query_dob")
    act.bio = params.fetch("query_bio")
    act.image = params.fetch("query_image")
    act.save
    redirect_to("/actors/" + id)
  end
end
