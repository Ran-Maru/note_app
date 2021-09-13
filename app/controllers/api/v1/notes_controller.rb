module Api
  module V1
    class NotesController < ApplicationController
      def index
        note = Note.where(user_id: 1)
        pretty_json note
      end
    end
  end
end
