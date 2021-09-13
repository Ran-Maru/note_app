module Api
  module V1
    class NotesController < ApplicationController
      def index
        note = Note.where(user_id: 1)
        pretty_json note
      end
      def create 
      end
      def update 
      end
      # メモを削除（ゴミ箱に移動）
      def thorowAway 
      end
      # メモを完全に削除（ゴミ箱から削除）
      def destroy 
      end
      # メモを検索
      def search
      end
    end
  end
end
