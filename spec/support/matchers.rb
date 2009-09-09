Spec::Matchers.define :be_a_new do |model_class|
  match do |record|
    model_class === record && record.new_record?
  end
end
