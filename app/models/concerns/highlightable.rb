module Highlightable
  # Verifica se tem mais de um filme/serie em destaque
  extend ActiveSupport::Concern
  included do
    validate :single_highlight

    def single_highlight
      any_entity = any_other_highlighted?(Movie)
      any_entity ||= any_other_highlighted?(Serie) unless any_entity
      errors.add(:single_highlight, 'Only one highlited entity is permitted') if highlighted && any_entity
    end

    def any_other_highlighted?(model)
      records = model.where(highlighted: true)
      return records.where.not(id: id).any? if instance_of?(model)

      records.any?
    end
  end
end
