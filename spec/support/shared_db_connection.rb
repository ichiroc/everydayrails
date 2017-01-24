# coding: utf-8
# テスト全体でDB接続を共有する
# Selenium は別スレッドで example を実行するためコミットされてないデータが別テストで参照できずDBの状態が一致しない。
# これはDB接続を共有することでその問題を起こりにくくする（駄目なケースもあるっぽい）
class ActiveRecord::Base
  mattr_accessor :shared_connection # MEMO: クラス変数のアクセサを定義
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
