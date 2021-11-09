# テスト用データ作成
user_id_1 = 1
user_id_2 = 2
time = Time.now
created_at = time
updatet_at = time

User.create!(email: "d@kakaku.com",
            sign_in_count: "a",
            password: "abcdefg",
            created_at: created_at,
            updated_at: updatet_at
            )

User.create!(email: "q@sakura.com",
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
               user_id: user_id_1,
               created_at: created_at,
               updated_at: updatet_at)
  Note.create!(title: title + "_2",
                content: content,
                user_id: user_id_2,
                created_at: created_at,
                updated_at: updatet_at)
  name = "ラベル#{n +1 }"
  Label.create!(name: name,
                user_id: user_id_1)
  Labeling.create!(note_id: 1,
                   label_id: n + 1)
end

3.times do |n|
  Labeling.create!(note_id: n + 2,
    label_id: n + 1) 
end
