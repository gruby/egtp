sample_transciption = "
1
0:00:00,000 --> 0:00:05,220
PRAYER TIME

2
0:00:05,220 --> 0:00:10,700
Prophet T.B. Joshua leads the congregation of The SCOAN and the viewers worldwide

3
0:00:10,700 --> 0:00:12,980
in a time of powerful prayer
"

require 'json'
langs = JSON.parse(File.read("#{Rails.root}/storage/global_languages.json"))

langs.values.each do |l|
  Language.create(:name => l)
end

u1 = User.create(:email => "robert@emmanuel", :language => "English", :admin => true, :password => "pass")
u2 = User.create(:email => "jibril@emmanuel", :language => "English", :admin => true, :password => "pass")

Right.create(:user => u1, :language => Language.find_by(name: "English"), :role => "TT")

1.upto(50) { |c| Item.create( 
  language: "English", 
  status: "READY FOR TT", 
  title: "Original nb #{c}", 
  content: sample_transciption,
  description: "Description of English item #{c}"
)}