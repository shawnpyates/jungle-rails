class ReviewsController < ApplicationController

  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def create
    product = Product.find(params[:product_id])
    @review = product.reviews.create(review_params)
    @review.user = current_user
    if @review.save
      redirect_to product, notice: 'Thank you for your feedback.'
    else
      redirect_to :back
    end
  end

  def destroy
    @review.destroy
    redirect_to product_url(@review.product), notice: 'Review was successfully destroyed.'
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:rating, :description)
    end

    
end
