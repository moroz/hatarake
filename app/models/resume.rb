class Resume < Attachment
  mount_uploader :file, ResumeUploader

  LANGUAGES = %w( bg cs da de el en es fi fr hr hu lt lv nl no pl ro ru sk sl sv ua zh_CN zh_TW )
  validates :language, inclusion: { in: LANGUAGES }
  EXTENSIONS = %w(pdf doc docx rtf odt)

  def pdf?
    file.content_type == 'application/pdf'
  end

  def pdf_url
    file.pdf.try(:url) || file_url
  end
end
