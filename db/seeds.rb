# テスト用データ作成
user_id = 1
time = Time.now
created_at = time
updatet_at = time

User.create!(email: "d@kakaku.com",
            sign_in_count: "a",
            password: "abcdefg",
            created_at: created_at,
            updated_at: updatet_at
            )

5.times do |n|
  title = "タイトル#{n + 1}"
  content = "テキスト#{n + 1}"
  Note.create!(title: title,
               content: content,
               user_id: user_id,
               created_at: created_at,
               updated_at: updatet_at)
  name = "ラベル#{n +1 }"
  Label.create!(name: name,
                user_id: user_id)
  Labeling.create!(note_id: 1,
                   label_id: n + 1)
end

3.times do |n|
  Labeling.create!(note_id: 2,
    label_id: n + 1) 
end
