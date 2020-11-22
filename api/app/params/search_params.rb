class SearchParams
  include ActiveModel::Validations

  attr_accessor :term, :engines, :offset

  validates :term, presence: true
  validates :engines, presence: true
  validate :validate_engines

  def initialize(term:, engines:, offset: 0)
    @term = term
    @engines = Searcher.engines_map.keys & Array(engines).map(&:to_sym)
    @offset = offset
  end

  def validate_engines
    errors.add :engines, 'provide at least one valid engine (google, bing)' if engines.empty?
  end

  def offset
    (@offset || 0).to_i
  end
end
