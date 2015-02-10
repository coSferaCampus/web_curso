module BSON
  class ObjectId
    def to_json
      to_s
    end

    def as_json(param = nil)
      to_s
    end
  end
end
