module ManageIQ
  module GraphQL
    module Types
      VmPowerOperation = ::GraphQL::EnumType.define do
        name 'VmPowerOperation'
        description 'Power operations you can perform on virtual machines.'
        value('START', 'Power on a virtual machine', :value => 'start')
        value('STOP', 'Power off a virtual machine', :value => 'stop')
        value('SUSPEND', 'Suspend a virtual machine', :value => 'suspend')
        value('PAUSE', 'Pause a virtual machine', :value => 'pause')
        value('RESET', 'Reset a virtual machine', :value => 'reset')
      end
    end
  end
end
