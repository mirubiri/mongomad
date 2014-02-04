require 'spec_helper'

describe UserUpdater do
  # Variables

  # Methods
  describe '#execute' do
    context 'when user exists' do
      pending 'update user data'
      pending 'call save method'
      pending 'call object finder'
      context 'when there are documents related to user' do
        pending 'call new method from outdater object decorator class'
        pending 'call outdate_objects method'
        pending 'call new method from outdater parents decorator class'
        pending 'call outdate_objectsparents method'
        pending 'call save for all documents /array'
      end
      context 'when there are not documents related to user' do
        pending 'no call new method from outdater object decorator class'
        pending 'no call outdate_objects method'
        pending 'no call new method from outdater parents decorator class'
        pending 'no call outdate_objectsparents method'
        pending 'no call save for all documents /array'
      end
      pending 'return true'
    end
    context 'when user does not exist' do
      pending 'does not call save method'
      pending 'does not call object finder'
      pending 'no call new method from outdater object decorator class'
      pending 'no call outdate_objects method'
      pending 'no call new method from outdater parents decorator class'
      pending 'no call outdate_objectsparents method'
      pending 'no call save for all documents /array'
      pending 'return false'
    end
  end
end
