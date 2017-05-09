module BelongsToActiveResource

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

    def ar_belongs_to( name, options = {} )
      class_eval %(
        def #{name}
          @#{name} ||= #{options[:class_name] || name.to_s.classify }.find( #{options[:foreign_key] || name.to_s + "_id" } )
        end

        def #{name}=(obj)
          @#{name} ||= obj
          self.#{ options[:foreign_key] || name.to_s + "_id" } = @#{name}.#{ options[:primary_key ] || 'id' }
        end
      )
    end

  end

end

ActiveRecord::Base.class_eval { include BelongsToActiveResource }
