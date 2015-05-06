module NamedObject
  extend ActiveSupport::Concern
  include Mongoid::Document

  HONORIFICS = %w{Mr. Ms Mrs. Dr.}

  included do
    field :honorific, type:String
    field :first_name, type:String
    field :middle_name, type:String
    field :last_name, type:String

    validates :honorific, presence: true, inclusion: {in: HONORIFICS}
    validates :first_name, presence: true, length: {minimum: 3}
    validates :last_name, presence: true, length: {minimum: 3}

    def formal_name
      "#{self.honorific} #{self.last_name}"
    end

    def full_name
      "#{self.first_name} #{self.last_name}"
    end

    def to_s
      self.full_name
    end

    def sorted_by_name
      order_by([[:last_name, :asc], [:first_name, :asc], [:middle_name, :asc]])
    end

  end
end
