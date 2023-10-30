langs = {"af":"Afrikaans","sq":"Albanian","am":"Amharic","ar":"Arabic","hy":"Armenian","az":"Azerbaijani","bg":"Bulgarian","zh":"Chinese","zh-CN":"Chinese (China)","zh-HK":"Chinese (Hong Kong)","zh-Hans":"Chinese (Simplified)","zh-TW":"Chinese (Taiwan)","zh-Hant":"Chinese (Traditional)","hr":"Croatian","cs":"Czech","nl":"Dutch","fil":"Filipino","fi":"Finnish","fr":"French","de":"German","el":"Greek","ht":"Haitian Creole","iw":"Hebrew","hi":"Hindi","hi-Latn":"Hindi (Phonetic)","hu":"Hungarian","ig":"Igbo","id":"Indonesian","it":"Italian","ja":"Japanese","kk":"Kazakh","km":"Khmer","rw":"Kinyarwanda","ko":"Korean","ky":"Kyrgyz","ln":"Lingala","lt":"Lithuanian","mg":"Malagasy","ms":"Malay","ml":"Malayalam","mn":"Mongolian","no":"Norwegian","fa-IR":"Persian (Iran)","pl":"Polish","pt":"Portuguese","ro":"Romanian","ru":"Russian","sm":"Samoan","sr":"Serbian","sn":"Shona","sk":"Slovak","sl":"Slovenian","so":"Somali","st":"Southern Sotho","es":"Spanish","sw":"Swahili","sv":"Swedish","ta":"Tamil","th":"Thai","ti":"Tigrinya","ts":"Tsonga","tn":"Tswana","uk":"Ukrainian","vi":"Vietnamese","xh":"Xhosa","yo":"Yoruba","zu":"Zulu","ot":"Other"}

Language.create(:name => "English", :id => 1)

langs.values.each do |l|
  Language.create(:name => l)
end

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

#require 'json'
#langs = JSON.parse(File.read("#{Rails.root}/storage/global_languages.json"))



robert = User.create(:email => "robert@em", :language_id => 1, :admin => true, :password => "pass")
jibril = User.create(:email => "jibril@em", :language_id => 1, :admin => true, :password => "pass")
gary = User.create(:email => "gary@em", :language_id => 1, :password => "pass")

Right.create(:user => robert, :language => Language.find(1), :role => "TT")
Right.create(:user => gary, :language => Language.find(1), :role => "LC")
Right.create(:user => gary, :language => Language.find(2), :role => "TT")
Right.create(:user => jibril, :language => Language.find(1), :role => "TT")
Right.create(:user => jibril, :language => Language.find(1), :role => "LC")

1.upto(50) { |c| Item.create( 
  language_id: 1, 
  status: 1, 
  title: "Original nb #{c}", 
  content: sample_transciption,
  description: "Description of English item #{c}"
)}

51.upto(55) { |c| Item.create( 
  language_id: 1, 
  status: 5, 
  title: "Original nb #{c}", 
  content: sample_transciption,
  description: "Description of English item #{c}"
)}
