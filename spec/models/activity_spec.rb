require 'rails_helper'

RSpec.describe Activity, type: :model do
  include_examples 'image_concern', 'sequence_concern_spec'

  let(:subject) { build :activity }

  describe 'Associations' do
    it 'belongs to main activity_sequence' do
      should belong_to(:activity_sequence)
    end

    it 'has and belongs to many activity types' do
      should have_and_belong_to_many(:activity_types)
    end

    it 'has and belongs to many curricular components' do
      should have_and_belong_to_many(:curricular_components)
    end
  end

  describe 'Validations' do
    context 'is valid' do
      it 'with valid attributes' do
        expect(subject).to be_valid
      end
    end

    context 'is not valid' do
      it 'without a sequence' do
        subject.sequence = nil

        expect(subject).to_not be_valid
      end

      it 'without a title' do
        subject.title = nil

        expect(subject).to_not be_valid
      end

      it 'if the title already exists' do
        subject.save
        new_object = build :activity, title: subject.title

        expect(new_object).to_not be_valid
      end

      it 'without a estimated_time' do
        subject.estimated_time = nil

        expect(subject).to_not be_valid
      end

      it 'without a content' do
        subject.content = nil

        expect(subject).to_not be_valid
      end

      it 'without a activity sequence' do
        subject.activity_sequence = nil

        expect(subject).to_not be_valid
      end
    end
  end

  describe 'methods' do
    context 'sequences' do
      it 'next return valid' do
        subject.save

        expect(subject.next_sequence).to eq(subject.sequence + 1)
      end

      it 'last return valid' do
        create_list(:activity, 3)
        second_activity = Activity.where(sequence: 2).last

        expect(second_activity.last_sequence).to eq(second_activity.sequence - 1)
      end

      it 'last sequence return nil if sequence <= 1' do
        subject.sequence = 1
        subject.save

        expect(subject.last_sequence).to eq(nil)
      end
    end

    context 'next activity' do
      it 'return nil if not exists' do
        subject.save

        expect(subject.next_activity).to be_nil
      end

      it 'return valid next activity' do
        create_list(:activity, 2)
        activities = Activity.all

        expect(activities.first.next_activity).to eq(activities.last)
      end
    end

    context 'last activity' do
      it 'return nil if not exists' do
        subject.save

        expect(subject.last_activity).to be_nil
      end

      it 'return valid last activity' do
        create_list(:activity, 2)
        activities = Activity.all

        expect(activities.last.last_activity).to eq(activities.first)
      end
    end

    context 'title must be in capital letter' do
      it 'on create' do
        subject.title = "title a"

        expect(subject.title).to eq("TITLE A")
      end

      it 'on edit' do
        subject.save
        subject.title = "new title"

        expect(subject.title).to eq("NEW TITLE")
      end
    end
  end
  it_behaves_like 'image_concern', 'sequence_concern_spec'
end
