class User < ApplicationRecord
  belongs_to :app

  has_secure_password

  def present
    {
      id: id,
      nickname: nickname,
      email: email,
      created_at: created_at.to_fs(:db),
      updated_at: updated_at.to_fs(:db)
    }
  end
end
