#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#

module ConsulCookbook
  module Helpers
    # @since 2.0
    module InstallationBinary # rubocop:disable Metrics/ModuleLength
      extend self

      def fancy_filename
        case node['kernel']['arch']
        when 'x86_64' then ['consul', version, node['os'], 'amd64'].join('_')
        when 'x86' then ['consul', version, node['os'], '386'].join('_')
        when 'arm' then ['consul', version, node['os'], 'arm'].join('_')
        end
      end

      def default_checksum
        case [node['os'], node['kernel']['arch']].join('-')
        when 'darwin-x86_64'
          case version
          when '0.5.0' then '24d9758c873e9124e0ce266f118078f87ba8d8363ab16c2e59a3cd197b77e964'
          when '0.5.1' then '161f2a8803e31550bd92a00e95a3a517aa949714c19d3124c46e56cfdc97b088'
          when '0.5.2' then '87be515d7dbab760a61a359626a734f738d46ece367f68422b7dec9197d9eeea'
          when '0.6.0' then '29ddff01368458048731afa586cec5426c8033a914b43fc83d6442e0a522c114'
          when '0.6.1' then '358654900772b3477497f4a5b5a841f2763dc3062bf29212606a97f5a7a675f3'
          when '0.6.2' then '3089f77fcdb922894456ea6d0bc78a2fb60984d1d3687fa9d8f604b266c83446'
          when '0.6.3' then '6dff4ffc61d66aacd627a176737b8725624718a9e68cc81460a3df9b241c7932'
          end
        when 'darwin-x86'
          case version
          when '0.6.0' then '95d57bfcc287bc344ec3ae8372cf735651af1158c5b1345e6f30cd9a9c811815'
          when '0.6.1' then '41dfcc0aefe0a60bdde413eaa8a4a0c98e396d6b438494f1cf29b32d07759b8e'
          when '0.6.2' then '973105816261c8001fcfa76c9fb707fa56325460476fb0daa97b9ece0602a918'
          when '0.6.3' then '7fb30756504cd9559c9b23e5d0d8d73a847ee62ed85d39955b5906c2f59a5bc1'
          end
        when 'solaris-x86_64'
          case version
          when '0.6.2' then 'f5655f0b173e5d51c5b92327d1fc7f24ac0939897a1966da09146e4eb75af9d1'
          when '0.6.3' then 'e6a286ff17a2345b8800732850eadb858b3dba9486355e1164a774ccec2f0e98'
          end
        when 'windows-x86_64'
          case version
          when '0.6.0' then '182beea0d8d346a9bfd70679621a5542aeeeea1f35be81fa3d3aeec2479bac3d'
          when '0.6.1' then '2be6b0f0fdebff00aea202e9846131af570676f52e2936728cbf29ffbb02f57f'
          when '0.6.2' then 'df3234fb7def7138b7cb8c73fe7c05942ec1e485925701a7b38fc7e2396a212f'
          when '0.6.3' then '04cd1fdc9cd3a27ffc64e312e40142db7af0d240608f8080ec6d238294b20652'
          end
        when 'windows-x86'
          case version
          when '0.5.0' then '7fd760ee8a5c2756391cacc1e924ae602b16cdad838db068e564f798383ad714'
          when '0.5.1' then 'bb9e1753cf793ad6f9db34bd6e18fb0fa5b0696a8a51a7f1c61484386dfe6682'
          when '0.5.2' then '2e866812de16f1a6138a0fd1eebc76143f1314826e3b52597a55ac510ae94be6'
          when '0.6.0' then '8379afd07668933c120880bba8228277e380abb14e07a6c45b94562ac19b37bd'
          when '0.6.1' then '10197d1f7be0d0087414c9965008ddd88e9fcd9ac9d5bd02d72d65eda36f5834'
          when '0.6.2' then 'f072d89c098dde143897e653d5adaf23125b58062344ef4be4029d635f959654'
          when '0.6.3' then '55733a730c5055d0ed1dc2656b2b6a27b21c7c361a907919cfae90aab2dff870'
          end
        when 'linux-x86_64'
          case version
          when '0.5.0' then '161f2a8803e31550bd92a00e95a3a517aa949714c19d3124c46e56cfdc97b088'
          when '0.5.1' then '967ad75865b950698833eaf26415ba48d8a22befb5d4e8c77630ad70f251b100'
          when '0.5.2' then '171cf4074bfca3b1e46112105738985783f19c47f4408377241b868affa9d445'
          when '0.6.0' then '307fa26ae32cb8732aed2b3320ed8daf02c28b50d952cbaae8faf67c79f78847'
          when '0.6.1' then 'dbb3c348fdb7cdfc03e5617956b243c594a399733afee323e69ef664cdadb1ac'
          when '0.6.2' then '7234eba9a6d1ce169ff8d7af91733e63d8fc82193d52d1b10979d8be5c959095'
          when '0.6.3' then 'b0532c61fec4a4f6d130c893fd8954ec007a6ad93effbe283a39224ed237e250'
          end
        when 'linux-x86'
          case version
          when '0.5.0' then '4b6147c30596a30361d4753d409f8a1af9518f54f5ed473a4c4ac973738ac0fd'
          when '0.5.1' then 'dad93a02c01de885daee191bcc5a05ca2bf106200da61db33694a658432d8399'
          when '0.5.2' then '29306ce398109f954ceeea3af79878be4fb0d949f8af3a27c95ccef2101e8f60'
          when '0.6.0' then 'f58f3f03a8b48d89bb8be94a6d1767393ad2a410c920b064066e01c7fa24f06c'
          when '0.6.1' then '34b8d4a2a9ec85082b6e93c6785ba9c54663fec414062e45dd4386db46a533c4'
          when '0.6.2' then '500ac8c75768b7f2d63521d2501ff8cc5fb7f9ddf6c550e9449364810c96f419'
          when '0.6.3' then '2afb65383ab913344daaa9af827c1e8576c7cae16e93798048122929b6e4cc92'
          end
        when 'linux-arm'
          case version
          when '0.6.0' then '425e7332789deb446a486ac25f7143aba5f16453ac46ede39b71ab6a361d8726'
          when '0.6.1' then '5b61e9ed10e02990aa8a2a0116c398c61608bc7f5051cb5a13750ffd47a54d51'
          when '0.6.2' then 'b6b4f66f6dd8b1d4ebbd0339f4ed78c4853c7bd0d42fd15af70179b5bc65482e'
          when '0.6.3' then 'c5fd5278be2757d2468bc7e263af15bc9a9e80fc5108fec658755804ea9bca56'
          end
        when 'freebsd-x86_64'
          case version
          when '0.6.0' then 'd7be5c95b971f48ccbd2c53c342dced9a3d0a5bc58f57b4f2e75672d96929923'
          when '0.6.1' then '04688dfabedf6ded7f3d548110c7d9ffc8d6d3a091062593e421702bc42b465d'
          when '0.6.2' then '1ccf96cb58c6fa927ee21c24d9be368ebe91559ed32626a89a715a3781659e3f'
          when '0.6.3' then '8bdf2da41e6118af18af9aba0a127d4abb3453a20a9064e1bd1206f5c11ac2c8'
          end
        when 'freebsd-x86'
          case version
          when '0.6.0' then 'c5eb9f5c211612148e1e1cd101670fd08fd1abf9b2e541ac2936ab9637626249'
          when '0.6.1' then '87d8c56c0c02e2fcde5192614dff9c491af93f7186fd55caae3fbe2c4d6ca80c'
          when '0.6.2' then 'fc87f2ddd2090031e79136954d9e3f85db480d5ed9eba6ae627bf460e4c95e6e'
          when '0.6.3' then '4a1aa8f570852eb238b7406172c097f5b32f41a3f01186111e576faa7506248c'
          end
        when 'freebsd-arm'
          case version
          when '0.6.0' then '92f29ad00f8f44d3be43b3b038a904c332757eb2a6848a7d6754583c2791e18b'
          when '0.6.1' then '7b907fbd4377671de1be2dc0c19f955e1b37cd862c1af8251e9bf6d668b0d3a8'
          when '0.6.2' then '30d8d09dd88cdd8d5256cea445fd0fed787d73cc6585e2eef7212161f29c8053'
          when '0.6.3' then '5452d29f1cf0720c4ae0e0ec1cc5e44b0068a0340a6b61ab5ec245fa0f3447ad'
          end
        end
      end
    end
  end
end
