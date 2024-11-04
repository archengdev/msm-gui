class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def insert
    dir = Director.new
    dir.name = params.fetch("query_name")
    dir.dob = params.fetch("query_dob")
    dir.bio = params.fetch("query_bio")
    dir.image = params.fetch("query_image")
    dir.id = rand(1000..100000)
    dir.save

    redirect_to("/directors")
  end
  def delete
    Director.destroy(params.fetch("id"))
    redirect_to("/directors")
  end
  def modify
    id = params.fetch("id")
    redirect_to("/directors")

  end
end
