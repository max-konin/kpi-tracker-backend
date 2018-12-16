require 'rails_helper'

RSpec.describe TaskPolicy do
  let(:user) { build_stubbed :user }

  subject { described_class }

  permissions '.scope' do
    subject { TaskPolicy::Scope.new(user, Task).resolve }
    it { is_expected.to eq Task.all }
  end

  permissions :show? do
    let(:task) { build_stubbed :task }
    it { expect(subject).to permit(user, task) }
  end

  permissions :create? do
    let(:task) { build_stubbed :task }
    it { expect(subject).to permit(user, task) }
  end

  permissions :update? do
    context 'the user is a creator of the task' do
      let(:task) { build_stubbed :task, user: user }
      it { expect(subject).to permit(user, task) }
    end
    context 'the user is not a creator of the task' do
      let(:task) { build_stubbed :task }
      it { expect(subject).not_to permit(user, task) }
    end
  end

  permissions :destroy? do
    context 'the user is a creator of the task' do
      let(:task) { build_stubbed :task, user: user }
      it { expect(subject).to permit(user, task) }
    end
    context 'the user is not a creator of the task' do
      let(:task) { build_stubbed :task }
      it { expect(subject).not_to permit(user, task) }
    end
  end
end
