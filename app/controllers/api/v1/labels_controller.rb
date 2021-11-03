module Api
  module V1
    class LabelsController < ApplicationController
      before_action :pre_check, only: [:update, :destroy]

      # FIXME: Can't verify CSRF token authenticity.
      protect_from_forgery

      # FIXME: 必要な値のみを返却するよう修正を行う。現状ではテーブルの値全てを返している。
      def index
        pretty_json Label.where(user_id: 1)
      end

      def create
        label = Label.new(label_params)
        if label.save
          labels = Label.where(user_id: 1)
          response = { status: 'SUCCESS', data: labels }
        else
          labels = Label.where(user_id: 1)
          response = { status: 'ERROR', message: label.errors, data: labels }
        end
        pretty_json response
      end

      # SQLが一行になるか検証
      def update
        if @label.update(label_params)
          labels = Label.where(user_id: 1)
          response = { status: 'SUCCESS', data: labels }
        else
          labels = Label.where(user_id: 1)
          response = { status: 'ERROR', message: @label.errors, data: labels }
        end
        pretty_json response
      end

      def destroy
        if @label.destroy
          labels = Label.where(user_id: 1)
          response = { status: 'SUCCESS', data: labels }
        else
          labels = Label.where(user_id: 1)
          response = { status: 'ERROR', message: @label.errors, data: labels }
        end
        pretty_json response
      end

      private

      def label_params
        params.require(:label).permit(:name, :user_id)
      end

      # beforeAction

      # 更新対象が存在するか確認
      def pre_check
        @label = Label.find_by(id: params[:id], user_id: params[:user_id])
        labels = Label.where(user_id: 1)
        response = { status: 'ERROR', message: 'Resource Not Found', data: labels }
        pretty_json response if @label.nil?
      end
    end
  end
end
