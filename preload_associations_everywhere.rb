# preload associations everywhere
# Rails < 7
ActiveRecord::Associations::Preloader.new.preload(array, :comments)
# Rails >= 7
ActiveRecord::Associations::Preloader.new(records: array, associations: :comments).call
