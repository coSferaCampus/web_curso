class Theme
  include Mongoid::Document
  include Mongoid::Timestamps

  TITLE_REGEXP = /## (.+)$/
  SUBTITLE_REGEXP = /### (.+)$/

  mount_uploader :file, ThemeUploader

  field :number,    type: Integer
  field :title,     type: String
  field :subtitles, type: Array
  field :content,   type: String

  belongs_to :subject

  validates :number, presence: true, uniqueness: true
  validates :file, presence: true
  validates :subject, presence: true

  after_create do
    set content: file.read
  end

  after_save do
    set_title
    set_subtitles
  end

  private

  # Use file content to set the theme title
  def set_title
    content =~ TITLE_REGEXP

    set title: $1
  end

  # Use file content to set the theme subtitles
  def set_subtitles
    self.subtitles = []
    content.gsub(SUBTITLE_REGEXP) do |word|
      self.subtitles << $1
    end
  end
end
