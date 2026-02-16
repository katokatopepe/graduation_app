class GamesController < ApplicationController
  before_action :require_login
  before_action :load_masters, only: %i[new create edit update]
  before_action :set_game, only: %i[show edit update destroy]

  def new
    @game = current_user.games.build
  end

  def create
    # ① 写真を params から先に取り出す（game_params に含めない）
    new_photos = extract_photos_from_params
    cached_signed_ids = extract_cached_signed_ids

    @game = current_user.games.build(game_params)

    if @game.save
      # ② 保存成功 → 写真をアタッチ
      attach_photos(@game, new_photos, cached_signed_ids)
      redirect_to dashboard_path, notice: "試合記録を登録しました"
    else
      # ③ バリデーションエラー → 写真を Blob にキャッシュ
      @cached_photo_signed_ids = cache_photos_as_blobs(new_photos) + cached_signed_ids
      flash.now[:alert] = "入力内容を確認してください"
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    # 1. 削除チェックされた写真を処理
    remove_ids = params.dig(:game, :remove_photo_ids)
    params[:game]&.delete(:remove_photo_ids)

    if remove_ids.present?
      ActiveStorage::Attachment.where(
        id: remove_ids,
        record_type: "Game",
        record_id: @game.id,
        name: "photos"
      ).each(&:purge)
      @game.reload  # キャッシュをクリア
    end

    # 2. 新規写真を取り出す
    new_photos = extract_photos_from_params

    # 3. 写真以外のフィールドを更新
    if @game.update(game_params)
      # 4. 新規写真を追記アタッチ
      new_photos.each { |photo| @game.photos.attach(photo) }
      redirect_to dashboard_path, notice: "試合記録を更新しました"
    else
      flash.now[:alert] = "入力内容を確認してください"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @game.destroy
      redirect_to dashboard_path, notice: "試合記録を削除しました"
    else
      # destroyがfalseになるケース（コールバックで止まる等）
      redirect_to dashboard_path, alert: "削除に失敗しました"
    end
  rescue ActiveRecord::RecordNotDestroyed => e
    Rails.logger.warn("Game destroy failed: #{e.message}")
    redirect_to dashboard_path, alert: "削除に失敗しました"
  end


  private

  def set_game
    @game = current_user.games.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to dashboard_path, alert: "その投稿は表示できません"
    return
  end

  def load_masters
    @teams = Team.order(:id)
    @stadiums = Stadium.order(:id)
  end

  # ★ photos を除外した params
  def game_params
    params.require(:game).permit(
      :date, :home_away, :starting_pitcher,
      :favorite_team_score, :opponent_score,
      :opponent_team_id, :stadium_id, :custom_stadium_name,
      :result, :video_url
    )
  end

  # --- 写真処理ヘルパー ---

  # params から写真ファイルを取り出す（game_params より先に呼ぶ）
  def extract_photos_from_params
    photos = params.dig(:game, :photos)
    params[:game]&.delete(:photos)
    return [] unless photos.present?

    Array(photos).select { |p| p.respond_to?(:read) }
  end

  # params からキャッシュ済み signed_id を取り出す
  def extract_cached_signed_ids
    ids = params.dig(:game, :cached_photo_signed_ids)
    params[:game]&.delete(:cached_photo_signed_ids)
    Array(ids).select(&:present?)
  end

  # 写真ファイルを Blob に保存し signed_id の配列を返す
  def cache_photos_as_blobs(photos)
    return [] unless photos.present?

    photos.filter_map do |photo|
      photo.rewind if photo.respond_to?(:rewind)
      blob = ActiveStorage::Blob.create_and_upload!(
        io: photo,
        filename: photo.original_filename,
        content_type: photo.content_type
      )
      blob.signed_id
    rescue StandardError => e
      Rails.logger.warn("Photo cache failed: #{e.message}")
      nil
    end
  end

  # 新規写真 + キャッシュ写真をまとめてアタッチ
  def attach_photos(game, new_photos, cached_signed_ids)
    new_photos.each { |photo| game.photos.attach(photo) }

    cached_signed_ids.each do |signed_id|
      blob = ActiveStorage::Blob.find_signed(signed_id)
      game.photos.attach(blob) if blob
    rescue StandardError => e
      Rails.logger.warn("Cached photo attach failed: #{e.message}")
    end
  end
end