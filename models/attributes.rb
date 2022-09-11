module Attributes
  def included
    values.each_key do |key|
      define_method key do
        self[key]
      end
    end
  end

  def touch
    update(updated_at: Time.now)
  end
end
