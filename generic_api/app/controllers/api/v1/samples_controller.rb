class Api::V1::SamplesController < Api::V1::ApiController
  def index
    @samples  = Sample.active
    render json: @samples
  end
end