class NotificationsController < ApplicationController
  before_action :authenticate!

  # GET /notifications.json
  def index
    @notifications = Notification
      .for_user(current_user)
      .by_priority
      .limit(50)

    respond_to do |format|
      format.html # Will render index.html.erb if you create it
      format.json { render json: @notifications }
    end
  end

  # GET /notifications/unread.json
  def unread
    limit = params[:limit]&.to_i || 100 # Default to 100, allow override

    @notifications = Notification
      .for_user(current_user)
      .unread
      .by_priority
      .limit(limit)

    respond_to do |format|
      format.json { render json: @notifications }
    end
  end

  # GET /notifications/unread_count.json
  def unread_count
    count = Notification.for_user(current_user).unread.count

    respond_to do |format|
      format.json { render json: { count: count } }
    end
  end

  # PATCH /notifications/:id/mark_as_read
  def mark_as_read
    @notification = Notification.find(params[:id])

    if @notification.recipient == current_user
      @notification.mark_as_read!
      respond_to do |format|
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.json { render json: { error: 'Unauthorized' }, status: :unauthorized }
      end
    end
  end

  # PATCH /notifications/mark_all_as_read
  def mark_all_as_read
    Notification.for_user(current_user).unread.update_all(unread: false)

    respond_to do |format|
      format.json { render json: { success: true } }
    end
  end

  # DELETE /notifications/:id
  def destroy
    @notification = Notification.find(params[:id])

    if @notification.recipient == current_user
      @notification.destroy
      respond_to do |format|
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.json { render json: { error: 'Unauthorized' }, status: :unauthorized }
      end
    end
  end

  # DELETE /notifications/clear_all
  def clear_all
    Notification.for_user(current_user).destroy_all

    respond_to do |format|
      format.json { render json: { success: true } }
    end
  end
end
