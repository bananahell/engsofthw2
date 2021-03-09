# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    @title_class = ''
    @release_class = ''
    if params[:sort_by] == "title"
      @title_class =  'hilite'
      @movies = Movie.all.sort_by { |m| m.title }
    elsif params[:sort_by] == "release"
      @release_class =  'hilite'
      @movies = Movie.all.sort_by { |m| m.release_date }
    else
      @movies = Movie.all
    end
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def new
    @movie = Movie.new
  end

  def create
    #@movie = Movie.create!(params[:movie]) #did not work on rails 5.
    @movie = Movie.create(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created!"
    redirect_to movies_path
  end

  def movie_params
    params.require(:movie).permit(:title,:rating,:description,:release_date)
  end

  def edit
    id = params[:id]
    @movie = Movie.find(id)
    #@movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    #@movie.update_attributes!(params[:movie])#did not work on rails 5.
    @movie.update(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated!"
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:notice] = "#{@movie.title} was deleted!"
    redirect_to movies_path
  end
end