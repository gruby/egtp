class Item < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :items
  has_many :events#, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :item, optional: true
  belongs_to :language
  validates_presence_of :language_id, inclusion: { in: Language.all.pluck(:id), message: "Please specify language" }
  validates_uniqueness_of :language_id, :scope => :item_id, :message => "Translation in this language already exists", if: :translation?
  normalizes :content, with: -> content { content.strip.gsub(/\n{3,}/, "\n\n") }

  def translation?
    language.name != "English"
  end

  def translation_in(lang)
    items.where("language_id = '#{lang}'").first
  end

  #def status_options
  #  ["READY FOR TT", "ONGOING TT", "READY FOR RV", "ONGOING RV", "REVISED"]
  #end

  def status_options
    {
      "FOR ADMIN"=>0,
      "READY FOR TT"=>1,
      "ONGOING TT"=>2,
      "READY FOR RV"=>3,
      "ONGOING RV"=>4,
      "REVISED"=>5
    }
  end

  def self.revised_originals
    where(["language_id = ? and status = ?", 1, 5])
  end

  def self.ready_for_tt_in(lang)
    if lang == 1
      where(["language_id = ? and status = ?", 1, 1])
    else
      #revised_originals.where.not( id: where(["language_id = ? and status != ?", "#{lang}", "READY FOR TT"]).pluck(:item_id) )
      revised_originals.where.not( id: where(["language_id = ? and status != ?", "#{lang}", 1]).pluck(:item_id) )
    end
  end

  def self.ready_for_rv_in(lang)
    where(["language_id = ? and status = ?", "#{lang}", 3])
  end

  def self.ongoing_tasks_in(lang)
    #where(["language_id = ? and status IN ?", "#{lang}", [2,4] ])
    #where(["name = :name and email = :email", { name: "Joe", email: "joe@example.com" }])
    where(language_id: lang).where(status: [2,4])
  end

  def name_task
    task = status[-2..-1]
    if task == "TT"
      if language_id == 1
        "transcription"
      else
        "translation in #{language.name}"
      end
    else 
      "revision in #{language.name}"
    end
  end
end