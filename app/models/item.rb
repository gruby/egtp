class Item < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :items
  has_many :events#, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :item, optional: true 
  validates_presence_of :language, inclusion: { in: Language.all.pluck(:name), message: "Please specify language" }
  validates_uniqueness_of :language, :scope => :item_id, :message => "Translation in this language already exists", if: :translation?

  def translation?
    language != "English"
  end

  def translation_in(lang)
    items.where("language = '#{lang}'").first
  end

  def status_options
    ["READY FOR TT", "ONGOING TT", "READY FOR RV", "ONGOING RV", "REVISED"]
  end

  def self.revised_originals
    where(["language = ? and status = ?", "English", "REVISED"])
  end

  def self.ready_for_tt_in(lang)
    if lang == "English"
      where(["language = ? and status = ?", "English", "READY FOR TT"])
    else
      revised_originals.where.not( id: where(["language = ? and status != ?", "#{lang}", "READY FOR TT"]).pluck(:item_id) )
    end
  end

  def self.ready_for_rv_in(lang)
    where(["language = ? and status = ?", "#{lang}", "READY FOR RV"])
  end

  def self.ongoing_tasks_in(lang)
    where(["language = ? and status LIKE ?", "#{lang}", "%ONGOING%" ])
  end

  def name_task
    task = status[-2..-1]
    if task == "TT"
      if language == "English"
        "transcription"
      else
        "translation in #{language}"
      end
    else 
      "revision in #{language}"
    end
  end
end