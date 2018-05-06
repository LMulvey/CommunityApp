module Api
  class ApiController < ApplicationController
    private

    def handle_index(model, params = {})
      params[:limit] = params[:limit].nil? ? 50 : params[:limit]
      params[:page] = params[:page].nil? ? 1 : params[:page]
      all_records = paginate(model.all.order(created_at: :desc), params)
      render(
        status: :ok, 
        json: { data: all_records }
      )
    end

    def handle_show(record)
      status = record.nil? ? :not_found : :ok
      render(
        status: status, 
        json: { data: record } 
      )
    end

    def index_params
      { limit: params[:limit], page: params[:offset] }
    end

    def paginate(model, params)
      page = params[:page].to_i - 1 # Keep page numbers natural (start at 0, req at 2)
      limit = params[:limit].to_i
      offset = page * limit

      model.limit(limit).offset(offset)
    end
  end
end
