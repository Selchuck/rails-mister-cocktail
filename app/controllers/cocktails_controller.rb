class CocktailsController < ApplicationController
  before_action :make_cocktail, only: [:show, :edit]

  def index
    @query = params[:query]
    @cocktails = if @query
                   Cocktail.where('LOWER(name) like ?', "%#{@query.downcase}%")
                 else
                   Cocktail.all
                 end
  end

  def show
  end

  def new
    @cocktail = Cocktail.new
  end

  def edit
  end

  def update
    @cocktails = Cocktail.find(params[:id])
    @cocktails.update(cocktail_params)
    redirect_to cocktails_path(@cocktails)
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @cocktails = Cocktail.find(params[:id])
    @cocktail.destroy
    redirect_to cocktails_path
  end
  private

  def make_cocktail
    @cocktail = Cocktail.find(params[:id])
    @doses = @cocktail.doses
    @dose = Dose.new
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :doses, :image)
  end
end
