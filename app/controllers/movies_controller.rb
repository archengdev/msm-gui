class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
  def insert
    mov = Movie.new
    mov.title = params.fetch("query_title")
    mov.year = params.fetch("query_year")
    mov.duration = params.fetch("query_duration")
    mov.image = params.fetch("query_image")
    mov.director_id = params.fetch("query_director_id")
    mov.description = params.fetch("query_description")
    mov.id = rand(1000..100000)
    mov.save
    redirect_to("/movies")
  end
  def delete
    Movie.destroy(params.fetch("id"))
    redirect_to("/movies")
  end
  def modify
    id = params.fetch("id")
    mov = Movie.where({:id => id})[0]
    mov.title = params.fetch("query_title")
    mov.year = params.fetch("query_year")
    mov.duration = params.fetch("query_duration")
    mov.image = params.fetch("query_image")
    mov.description = params.fetch("query_description")
    mov.save
    redirect_to("/movies/" + id)
  end


end
