class Band < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  
  private
  def band_params
    params.require(:band).permit(:name)
  end
end
