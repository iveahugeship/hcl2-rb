class Hash
  def has_child?
    return false if empty?

    each do |_k, v|
      return false unless v.is_a?(Hash)
    end

    true
  end

  def to_hcl2(level: 0, spaces: 2)
    hcl2 = []

    each do |k, v|
      case v
      when Numeric, String, TrueClass, FalseClass, Array
        hcl2.push("#{k} = #{v.to_hcl2}\n")
      when Hash
        labels = HCL2::Helpers.dfs(v)
        labels.each do |label|
          # It creates a label string and we shouldn't
          # forget about addition space before this one
          n = label.empty? ? nil : label.map { |l| l&.to_hcl2 }.join('').prepend(' ') # It creates label string

          # We should go deeper to format child attributes
          c = label.empty? ? v : v.dig(*label)

          hcl2.push("#{k}#{n} {")
          hcl2.push(c.to_hcl2(level: level + 1))
          hcl2.push("}\n")
        end
      else
        raise "#{v.class.name} can't be formatted to HCL2"
      end
    end

    hcl2.map { |v| v.prepend(' ' * (spaces * level)) }.join("\n")
  end
end

class Numeric
  def to_hcl2
    to_s
  end
end

class String
  def to_hcl2
    inspect
  end
end

class Symbol
  def to_hcl2
    to_s.to_hcl2
  end
end

class TrueClass
  def to_hcl2
    to_s
  end
end

class FalseClass
  def to_hcl2
    to_s
  end
end

class Array
  def to_hcl2
    to_s
  end
end
