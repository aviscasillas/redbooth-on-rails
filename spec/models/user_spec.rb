# encoding: utf-8
require 'rails_helper'

describe User do
  describe '.from_omniauth' do
    let(:auth_hash) do
      {
        provider: 'redbooth',
        uid: '656485',
        info: {
          name: 'Andrés Bravo',
          email: 'andres.bravo@redbooth.com'
        },
        credentials: {
          token: 'b0e722c2c7a94f20de4blol439579ac06b26ed89a',
          refresh_token: '36d4706cdf4efedlol6dde1dac1b637b7',
          expires_at: '1409939217',
          expires: 'true'
        },
        extra: {
          raw_info: {
            type: 'User',
            created_at: '1370420186',
            updated_at: '1409904971',
            id: '65642185',
            first_name: 'Andrés',
            last_name: 'Bravo',
            email: 'andres.bravo@redbooth.com',
            needs_profile: 'false',
            deleted: 'false',
            bouncing_email: 'false',
            confirmed_user: 'true',
            username: 'lol',
            avatar_url: 'https://secure.gravatar.com/avatar/5de4c7ba680c829033alolfd29?size=48&default=mm',
            profile_avatar_url: 'https://secure.gravatar.com/avatar/5de4c7ba680clolf86afd29?size=278&default=mm',
            micro_avatar_url: 'https://secure.gravatar.com/avatar/5de4c7ba68lol3ac0ed1f86afd29?size=24&default=mm',
            first_day_of_week: 'monday',
            biography: 'developer',
            locale: 'en',
            time_zone: 'Madrid',
            default_digest: '4',
            notify_conversations: 'false',
            notify_tasks: 'false',
            notify_pages: 'false',
            default_watch_new_task: 'false',
            default_watch_new_conversation: 'false',
            default_watch_new_page: 'false',
            digest_delivery_hour: '12',
            wants_task_reminder: 'false',
            rss_token: '30804ee9a4c59lol3179883b089c95',
            calendar_token: 'a86ba8c08f0lolf16513c9a52f9',
            shortcut_apps: 'null',
            project_activity_digest: 'no_digest',
            chat_token: '38bece53lol5f61532d',
            do_not_disturb_at: 'null',
            is_pro: 'true'
          }
        }
      }
    end

    let(:auth) do
      OmniAuth::AuthHash.new(auth_hash)
    end

    let(:new_params) { { info: { name: 'Some New Name' } } }
    subject { User.from_omniauth(auth.merge(new_params)) }

    context 'with none existing user' do
      it 'creates a new user' do
        expect { subject }.to change(User, :count).from(0).to(1)
      end
    end

    context 'with existing user' do
      before { User.from_omniauth(auth) }

      it 'does not create a new user' do
        expect { subject }.to_not change(User, :count)
      end

      it 'updates the existing user' do
        expect(subject.name).to eq new_params[:info][:name]
      end
    end
  end
end
