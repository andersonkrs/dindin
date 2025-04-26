class IceCube::Rule::Type < ActiveRecord::Type::Value
  def deserialize(json_rule)
    return if json_rule.blank?

    IceCube::Rule.from_hash JSON.parse(json_rule)
  end

  def serialize(rule)
    return if rule.blank?

    JSON.dump rule.to_hash
  end
end

ActiveRecord::Type.register(:ice_cube_rule, IceCube::Rule::Type)
