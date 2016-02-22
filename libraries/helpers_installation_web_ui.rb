#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#

module ConsulCookbook
  module Helpers
    # @since 2.0
    module InstallationWebUi # rubocop:disable Metrics/ModuleLength
      extend self

      def fancy_filename
        ['consul', version, 'web_ui'].join('_')
      end

      def default_checksum
        case version
        when '0.5.0' then '0081d08be9c0b1172939e92af5a7cf9ba4f90e54fae24a353299503b24bb8be9'
        when '0.5.1' then 'ad883aa52e1c0136ab1492bbcedad1210235f26d59719fb6de3ef6464f1ff3b1'
        when '0.5.2' then 'ad883aa52e1c0136ab1492bbcedad1210235f26d59719fb6de3ef6464f1ff3b1'
        when '0.6.0' then '73c5e7ee50bb4a2efe56331d330e6d7dbf46335599c028344ccc4031c0c32eb0'
        when '0.6.1' then 'afccdd540b166b778c7c0483becc5e282bbbb1ee52335bfe94bf757df8c55efc'
        when '0.6.2' then 'f144377b8078df5a3f05918d167a52123089fc47b12fc978e6fb375ae93afc90'
        when '0.6.3' then '93bbb300cacfe8de90fb3bd5ede7d37ae6ce014898edc520b9c96a676b2bbb72'
        end
      end
    end
  end
end
