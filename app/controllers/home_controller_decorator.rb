Spree::HomeController.class_eval do
  # トップページを表示するindexメソッドと共に投稿を表示するload_entriesメソッドを読み込む
  before_action :load_entries, only: :index

  # 投稿記事を読み込むメソッドを定義
  def load_entries
    # 最新の3件を読み込む
    @entries = Spree::BlogEntry.recent(3)
  end
end
