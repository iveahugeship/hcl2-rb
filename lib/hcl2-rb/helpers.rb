# rubocop:disable Naming/MethodParameterName, Lint/NestedMethodDefinition
module HCL2
  module Helpers
    # This is just the Deep Find Search algorithm
    # using to flatten Hash like it make HCL2
    def self.dfs(g)
      def self.f(g, r, c)
        unless g.has_child?
          r.push(c.flatten)
          return
        end

        g.each do |k, v|
          c.push(k)
          f(v, r, c)
          c.delete(k)
        end
      end

      res = []
      cur = []
      f(g, res, cur)

      res
    end
  end
end
# rubocop:enable Naming/MethodParameterName, Lint/NestedMethodDefinition
