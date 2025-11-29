class SkillExtractorService
  def self.extract(text)
    return [] if text.blank?

    matched_skills = find_matching_skills(text.downcase)
    remove_substring_duplicates(matched_skills)
  end

  # Private class methods
  class << self
    private

    def find_matching_skills(lowercased_text)
      matched = []

      Skill.find_each do |skill|
        matched << skill if skill_matches?(skill, lowercased_text)
      end

      matched
    end

    def skill_matches?(skill, lowercased_text)
      searchable_terms = ([skill.name] + skill.aliases)
                         .compact
                         .map(&:downcase)
                         .sort_by { |term| -term.length }

      searchable_terms.any? { |term| lowercased_text.match?(/\b#{Regexp.escape(term)}\b/) }
    end

    def remove_substring_duplicates(skills)
      skills.reject do |skill|
        skills.any? { |other| other != skill && other.name.downcase.include?(skill.name.downcase) }
      end.uniq
    end
  end
end
