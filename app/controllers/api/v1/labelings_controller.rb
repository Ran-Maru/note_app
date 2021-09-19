module Api
  module V1
    class LabelingsController < ApplicationController
      before_action :pre_check, only: [:destroy]

      # FIXME: Can't verify CSRF token authenticity.
      protect_from_forgery

      def create
        @labeling = Labeling.new(labeling_params)
        if @labeling.save
          response = { status: 'SUCCESS', message: @labeling }
        else
          response = { status: 'ERROR', message: @labeling.errors }
        end
        pretty_json response
      end

      # FIXME: 必要な値のみを返却するよう修正を行う。現状ではテーブルの値全てを返している。
      def destroy
        if @labeling.destroy
          response = { status: 'SUCCESS', message: @labeling }
        else
          response = { status: 'ERROR', message: @labeling.errors }
        end
        pretty_json response
      end

      private

      def labeling_params
        params.require(:labeling).permit(:note_id, :label_id)
      end

      # beforeAction

      # 更新対象が存在するか確認
      def pre_check
        @labeling = Labeling.find_by(id: params[:id])
        response = { status: 'ERROR', message: 'Resource Not Found' }
        pretty_json response if @labeling.nil?
      end
    end
  end
end
