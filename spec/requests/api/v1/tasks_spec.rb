require 'rails_helper'

RSpec.describe 'Api::V1::Tasks', type: :request do
  let!(:application) { create :application } # OAuth application
  let!(:user)        { create :user }
  let!(:token)       { create :access_token, application: application, resource_owner_id: user.id }

  let(:headers) { { 'Authorization': "Bearer #{token.token}" } }

  RSpec.shared_examples 'unauthorized request' do
    it { expect(response).to have_http_status(401) } 
  end

  describe 'GET /api/v1/tasks' do
    context 'with token' do
      context 'w/o filters' do
        let!(:task) { create :task }
        before { get '/api/v1/tasks', headers: headers }
        it { expect(response).to have_http_status(200) } 
        it { expect(json['data'].size).to eq(1) }
      end
      context 'with filter' do
        let!(:task1) { create :task, kpi_points: 10 }
        let!(:task2) { create :task, kpi_points: 1 }
        before { get '/api/v1/tasks', headers: headers, params: { q: { kpi_points_eq: 10 } } }
        it { expect(response).to have_http_status(200) } 
        it { expect(json['data'].size).to eq(1) }
      end
    end
    context 'without token' do
      before { get "/api/v1/tasks" }

      it_behaves_like 'unauthorized request'
    end
  end

  describe 'GET /api/v1/tasks/:id' do
    let!(:task) { create :task }
    context 'with token' do
      context 'when a task with passed id exists' do
        before { get "/api/v1/tasks/#{task.id}", headers: headers }
        it { expect(response).to have_http_status(200) } 
        it 'renders the task in JSON:API format' do
          data = json['data']
          expect(data['id']).to eq task.id.to_s
          expect(data['type']).to eq 'tasks'
          expect(data['attributes']['kpi-points']).to eq task.kpi_points
          expect(data['attributes']['notes']).to eq task.notes
          expect(data['relationships']).to eq(
            'user'     => { 'data' => { 'type' => 'users', 'id' => task.user_id.to_s } },
            'category' => { 'data' => { 'type' => 'categories', 'id' => task.category_id.to_s } }
          )
        end
        it 'should include user and category' do
          included = json['included']
          expect(included.any? { |d| d['type'] == 'users'} ).to be_truthy
          expect(included.any? { |d| d['type'] == 'categories'} ).to be_truthy
        end
      end

      context 'when a task with passed id does not exist' do
        before { get '/api/v1/tasks/999', headers: headers }
        it { expect(response).to have_http_status(404) } 
      end
    end
    context 'without token' do
      before { get "/api/v1/tasks" }

      it_behaves_like 'unauthorized request'
    end
  end

  describe 'POST /api/v1/tasks' do
    context 'with token' do
      before { post '/api/v1/tasks', headers: headers, params: attrs}

      let(:attrs) { ActiveModelSerializers::SerializableResource.new(task).as_json }
      let(:expected_task_attrs) do
        {
          category_id: task.category_id,
          kpi_points: task.kpi_points,
          notes: task.notes,
          task_finished_at: task.task_finished_at,
          user_id: user.id
        }
      end

      context 'with valid attributes' do
        let(:task) { build :task }

        it { expect(response).to have_http_status(201) }
        it { expect(Task.where(expected_task_attrs).count).to eq 1 }
      end
      context 'with invalid attributes' do
        let(:task) { build :task, kpi_points: -1 }

        it { expect(response).to have_http_status(422) }
        it { expect(Task.where(expected_task_attrs).count).to eq 0 }
      end
    end

    context 'without token' do
      before { post '/api/v1/tasks' }
      it_behaves_like 'unauthorized request'
    end
  end

  describe 'PUT /api/v1/tasks/:id' do
    context 'with token' do
      before { put "/api/v1/tasks/#{task.id}", headers: headers, params: attrs}

      let(:attrs) { ActiveModelSerializers::SerializableResource.new(new_task).as_json }
      let(:expected_task_attrs) do
        {
          category_id: new_task.category_id,
          kpi_points: new_task.kpi_points,
          notes: new_task.notes,
          task_finished_at: new_task.task_finished_at,
          user_id: user.id
        }
      end

      context 'current user is an owner of the task' do
        let(:task) { create :task, user: user }

        context 'with valid attributes' do
          let(:new_task) { build :task }

          it { expect(response).to have_http_status(200) }
          it { expect(Task.where(expected_task_attrs).count).to eq 1 }
        end
        context 'with invalid attributes' do
          let(:new_task) { build :task, kpi_points: -1 }

          it { expect(response).to have_http_status(422) }
          it { expect(Task.where(expected_task_attrs).count).to eq 0 }
        end
      end

      context 'current user is not an owner of the task' do
        let(:task) { create :task }
        let(:new_task) { build :task }
        it_behaves_like 'unauthorized request'
      end
    end

    context 'without token' do
      let(:task) { create :task }
      before { put "/api/v1/tasks/#{task.id}" }
      it_behaves_like 'unauthorized request'
    end
  end

  describe 'DELETE /api/v1/tasks/:id' do
    context 'with token' do
      subject { delete "/api/v1/tasks/#{task.id}", headers: headers}

      context 'current user is an owner of the task' do
        let!(:task) { create :task, user: user }

        let(:new_task) { build :task }

        it { expect { subject }.to change { Task.count }.by -1 }
      end

      context 'current user is not an owner of the task' do
        let!(:task) { create :task }
        before { subject }
        it_behaves_like 'unauthorized request'
        it { expect(Task.count).to eq 1 }
      end
    end

    context 'without token' do
      let(:task) { create :task }
      before { delete "/api/v1/tasks/#{task.id}" }
      it_behaves_like 'unauthorized request'
    end
  end
end
