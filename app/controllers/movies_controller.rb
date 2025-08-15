class MoviesController < ApplicationController
  def index
    @all_ratings   = Movie.all_ratings
    @ratings_to_show = (params[:ratings]&.keys || session[:ratings] || @all_ratings)
    @sort            = (params[:sort] || session[:sort])

    session[:ratings] = @ratings_to_show
    session[:sort]    = @sort

    @movies = Movie.where(rating: @ratings_to_show)
    @movies = @movies.order(@sort) if @sort.present?
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  # HW: Find movies with the same director
  def same_director
    @movie = Movie.find(params[:id])
    if @movie.director.blank?
      flash[:notice] = "'#{@movie.title}' has no director info"
      redirect_to movies_path
    else
      @movies = Movie.with_same_director(@movie)
      render :same_director
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end
end
