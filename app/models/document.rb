class Document < ApplicationRecord
  has_neighbors :embedding
  belongs_to :library
  belongs_to :user

  validates :library, presence: true

  # Prevent DDOS and generally excessively large docs
  validates :token_count, presence: true, numericality: { less_than: 10_000 }

  validates :length, presence: true

  validates :document, presence: true,
                       uniqueness: { scope: :check_hash, message: 'Document with same content already exists.' }

  before_validation :calculate_length, :calculate_tokens, :calculate_hash

  def calculate_length
    # Calculate the length of the 'document' column and store it in the 'length' column
    return unless document

    self.length = document.length
  end

  def calculate_tokens
    self.token_count = (count_tokens(document) if document)
  end

  def calculate_hash
    return unless document

    # get shasum to detect duplicates
    sha = Digest::SHA2.hexdigest(document)
    self.check_hash = sha
  end

  DEFAULT_MODEL = 'gpt-3.5-turbo'

  def count_tokens(string, model: DEFAULT_MODEL)
    get_tokens(string, model:)
  end

  def get_tokens(string, model: DEFAULT_MODEL)
    encoding = Tiktoken.encoding_for_model(model)
    tokens = encoding.encode(string)
    tokens.length
  end
end
