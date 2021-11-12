module Api
  module V1
    class NotesController < ApplicationController
      before_action :pre_check, only: [:update]
      before_action :pre_index_check, only: [:index, :search]

      # FIXME: Can't verify CSRF token authenticity.
      protect_from_forgery

      def index
        note = Note.select("notes.*").eager_load(:labels).order(updated_at: "DESC").where(@indexParams)
        # ラベル情報をネストしたnoteのjsonを取得し、配列型に変換する。
        note_data = JSON.parse(note.to_json(include: [{labels: {only: [:id, :name] }}]))
        response = { status: 'SUCCESS', data: note_data}
        pretty_json response
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
      def throwAway
        # ','区切りで受け取ったidを型変換
        id_params_arr = params[:id].split(',')
        data = Note.where(user_id: params[:user_id])
                    .merge(Note.where(id: id_params_arr))
                    .update_all(is_trash: true)
        response = { status: 'SUCCESS', data: data }
        pretty_json response
      end

      # ゴミ箱から復元する。
      def restoreNote
        id_params_arr = params[:id].split(',')
        data = Note.where(user_id: params[:user_id])
                    .merge(Note.where(id: id_params_arr))
                    .update_all(is_trash: false)
        response = { status: 'SUCCESS', data: data }
        pretty_json response
      end

      def archive
        id_params_arr = params[:id].split(',')
        data = Note.where(user_id: params[:user_id])
                    .merge(Note.where(id: id_params_arr))
                    .update_all(is_archived: true)
        response = { status: 'SUCCESS', data: data }
        pretty_json response
      end

      def unarchive
        id_params_arr = params[:id].split(',')
        data = Note.where(user_id: params[:user_id])
                    .merge(Note.where(id: id_params_arr))
                    .update_all(is_archived: false)
        response = { status: 'SUCCESS', data: data }
        pretty_json response
      end

      # メモを完全に削除（ゴミ箱から削除）
      def destroy
        id_params_arr = params[:id].split(',')
        data = Note.where(user_id: params[:user_id]).merge(Note.where(id: id_params_arr)).destroy_all
        response = { status: 'SUCCESS', data: data }
        pretty_json response
      end

      def emptyTrash
        Note.where(user_id: params[:user_id], is_trash: 1).destroy_all
        response = { status: 'SUCCESS', data: '' }
        pretty_json response
      end

      # メモを検索
      def search
        keyword = params[:search_word]
        sanitized_keyword = Note.sanitize_sql_like(keyword)
        like_query = 'title like ? or content like ?'
        # 部分一致検索を実行
        data = Note.select("notes.*").eager_load(:labels)
                   .order(updated_at: "DESC")
                   .where(user_id: params[:user_id])
                   .where(@indexParams)
                  .where(like_query, "%#{sanitized_keyword}%", "%#{sanitized_keyword}%")
        # ラベル情報をネストしたnoteのjsonを取得し、配列型に変換する。
        hierarchy_data = JSON.parse(data.to_json(include: [{labels: {only: [:id, :name] }}]))
        response = { status: 'SUCCESS', data: hierarchy_data }
        pretty_json response
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

      def pre_index_check
        # APIの引数で指定がなければ、is_trash = falseで一覧取得をおこなう。
        is_trash = params[:is_trash]
        is_trash = false if is_trash.nil?

        isArchived = params[:is_archived]
        isArchived = false if isArchived.nil?

        # サーチparam用のハッシュを宣言
        @indexParams = {}
        @indexParams["user_id"] = 1
        @indexParams["is_trash"] = is_trash
        @indexParams["is_archived"] = isArchived
        if params[:label_id].present?
          @indexParams["labelings.label_id"] = params[:label_id]
        end
      end
    end
  end
end
