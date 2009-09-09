Spec::Matchers.define :be_a_new do |model_class|
  match do |record|
    model_class === record && record.new_record?
  end
end

Spec::Matchers.define :display_the do |card|
  match do |response|
    response.body.include?(card.title) && 
    response.body.include?(card.description) &&
    response.body.include?(card.points.to_s)
  end
  failure_message_for_should do |response|
    "expected the html\n#{response.body} to display the card #{card.inspect}"
  end
end

