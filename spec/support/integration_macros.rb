module IntegrationMacros
  extend ActiveSupport::Concern

  module ClassMethods
    ##
    # Creates a integration testing context with a particular
    # type of user.
    #
    # Accepts keyword arguments which are given directly to
    # the User factory to customize the user as the test sees fit.
    #
    # The 'role' keyword is the role to be given to the user;
    # **For brevity, the role is mutated as the suffix of seeded MIQ roles:**
    # 'administrator' -> 'EvmRole-administrator'
    # If no role is given, 'user' (EvmRole-user) is used
    #
    # Example:
    #
    #  ```
    #  describe 'when the app is down for maintenance' do
    #    as_user(:role => 'super_administrator') do
    #      it 'still allows the user to log in' do
    #        # user's miq_user_role is 'EvmRole-super_administrator'
    #      end
    #    end
    #
    #    as_user(:name => "Chris") do
    #      it 'doesn't allow the user to log in' do
    #        # user's name is 'Chris'
    #        # user's miq_user_role is 'EvmRole-user'
    #      end
    #    end
    #  end
    #  ```
    def as_user(**user_factory_options, &block)
      role = user_factory_options[:role] || 'user'
      context "as #{indefinitize(role)}" do
        let(:user) do
          options = user_factory_options.merge(:role => "EvmRole-#{role}")
          FactoryGirl.create(:user, options)
        end
        let(:server) { FactoryGirl.create(:miq_server) }

        before do
          create_primordials
        end

        class_exec(&block)
      end
    end

    private

    A_REQUIRING_PATTERNS = /^(([bcdgjkpqtuvwyz]|onc?e|onearmed|onetime|ouija)$|e[uw]|uk|ubi|ubo|oaxaca|ufo|ur[aeiou]|use|ut([^t])|unani|uni(l[^l]|[a-ko-z]))/i
    AN_REQUIRING_PATTERNS = /^([aefhilmnorsx]$|hono|honest|hour|heir|[aeiou]|8|11)/i
    private_constant :A_REQUIRING_PATTERNS, :AN_REQUIRING_PATTERNS

    def indefinitize(word_or_phrase)
      first_word = word_or_phrase.to_s.split(/[- ]/).first
      article = unless first_word.nil?
                  if (first_word[AN_REQUIRING_PATTERNS]) && !(first_word[A_REQUIRING_PATTERNS])
                    'an'
                  else
                    'a'
                  end
                end
      "#{article} #{word_or_phrase}"
    end
  end

  def encode_basic_auth_credentials(user, password)
    ActionController::HttpAuthentication::Basic.encode_credentials(user, password)
  end

  private

  ##
  # Creates the minimum required records to have a functional
  # integration test
  def create_primordials
    Tenant.create!(:use_config_for_attributes => false)
    allow(MiqServer).to receive(:my_guid).and_return(server.guid)
    MiqServer.my_server_clear_cache
  end
end