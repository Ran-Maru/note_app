module Api
  module V1
    class NotesController < ApplicationController
      def index
        render json: {status: 200, message: 'success!' }
      end
    end
  end
end
