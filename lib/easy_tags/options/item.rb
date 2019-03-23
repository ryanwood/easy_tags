module EasyTags
  module Options
    # Represents a single option item
    class Item
      def initialize(option)
        @option = option
      end

      # @return [Boolean]
      def valid?
        /[@$"]/ !~ name.inspect
      end

      # @return [Symbol]
      def name
        @_filter ||= key.to_sym
      end

      def callbacks
        return [] unless has_callbacks?

        @option.values.first.map do |type, callback|
          Callback.new(callback: callback, type: type)
        end
      end

      private

        def key
          return @option.keys.first if has_callbacks?
          @option
        end

        def has_callbacks?
          @option.is_a?(Hash)
        end
    end
  end
end
