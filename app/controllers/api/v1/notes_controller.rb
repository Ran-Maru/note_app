module Api
  module V1
    class NotesController < ApplicationController
      before_action :pre_check, only: [:update]
      
      # FIXME: Can't verify CSRF token authenticity.
      protect_from_forgery

      def index
        note = Note.where(user_id: 1)
        pretty_json note
      end

      def create
        note = Note.new(note_params)
        if note.save
          response = { status: 'SUCCESS', data: note }
        else
          response = { status: 'ERROR', data: note.errors }
        end
        pretty_json response
      end

      # TODO: 実装完了後。他人のメモを更新できない仕組みになっているか検証する。
      def update
        if @note.update(note_updating_params)
          response = { status: 'SUCCESS', data: @note }
        else
          response = { status: 'ERROR', data: @note.errors }
        end
        pretty_json response
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

      private

      # FIXME: API実行に失敗すると長文のjsが出力されるので、出ないよう対策を検討する。
      def note_params
        params.require(:note).permit(:title, :content, :user_id)
      end

      # OPTIMIZE: アクションごとにStrongParameterを用意する方法がRails作法として正しいか調べる。
      def note_updating_params
        params.require(:note).permit(:title, :content)
      end

      # beforeAction

      # 更新対象が存在するか確認
      def pre_check
        @note = Note.find_by(id: params[:id], user_id: params[:user_id])
        response = { status: 'ERROR', message: 'Resource Not Found' }
        pretty_json response if @note.nil?
      end
    end
  end
end
