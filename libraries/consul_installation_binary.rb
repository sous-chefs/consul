#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'
require_relative './helpers'

module ConsulCookbook
  module Provider
    # A `consul_installation` provider which manages Consul binary
    # installation from remote source URL.
    # @action create
    # @action remove
    # @provides consul_installation
    # @example
    #   consul_installation '0.5.0'
    # @since 2.0
    class ConsulInstallationBinary < Chef::Provider
      include Poise(inversion: :consul_installation)
      include ::ConsulCookbook::Helpers
      provides(:binary)
      inversion_attribute('consul')

      # @api private
      def self.provides_auto?(_node, _resource)
        true
      end

      # Set the default inversion options.
      # @return [Hash]
      # @api private
      def self.default_inversion_options(node, resource)
        extract_path = node.platform_family?('windows') ? node.config_prefix_path : '/opt/consul'
        super.merge(extract_to: extract_path,
                    version: resource.version,
                    archive_url: 'https://releases.hashicorp.com/consul/%{version}/%{basename}',
                    archive_basename: binary_basename(node, resource),
                    archive_checksum: binary_checksum(node, resource))
      end

      def action_create
        notifying_block do
          directory join_path(options[:extract_to], new_resource.version) do
            mode '0755'
            recursive true
          end

          url = format(options[:archive_url], version: options[:version], basename: options[:archive_basename])
          poise_archive url do
            destination join_path(options[:extract_to], new_resource.version)
            source_properties checksum: options[:archive_checksum]
            strip_components 0
            not_if { ::File.exist?(consul_program) }
          end

          link '/usr/local/bin/consul' do
            to ::File.join(options[:extract_to], new_resource.version, 'consul')
            not_if { windows? }
          end
        end
      end

      def action_remove
        notifying_block do
          directory join_path(options[:extract_to], new_resource.version) do
            action :delete
            recursive true
          end
        end
      end

      def consul_program
        @program ||= join_path(options[:extract_to], new_resource.version, 'consul')
        windows? ? @program + '.exe' : @program
      end

      def self.binary_basename(node, resource)
        case node['kernel']['machine']
        when 'x86_64', 'amd64' then ['consul', resource.version, node['os'], 'amd64'].join('_')
        when /i\d86/ then ['consul', resource.version, node['os'], '386'].join('_')
        when /^arm/ then ['consul', resource.version, node['os'], 'arm'].join('_')
        else ['consul', resource.version, node['os'], node['kernel']['machine']].join('_')
        end.concat('.zip')
      end

      def self.binary_checksum(node, resource)
        tag = node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : node['kernel']['machine']
        case [node['os'], tag].join('-')
        when 'darwin-amd64'
          case resource.version
          when '0.5.0' then '24d9758c873e9124e0ce266f118078f87ba8d8363ab16c2e59a3cd197b77e964'
          when '0.5.1' then '161f2a8803e31550bd92a00e95a3a517aa949714c19d3124c46e56cfdc97b088'
          when '0.5.2' then '87be515d7dbab760a61a359626a734f738d46ece367f68422b7dec9197d9eeea'
          when '0.6.0' then '29ddff01368458048731afa586cec5426c8033a914b43fc83d6442e0a522c114'
          when '0.6.1' then '358654900772b3477497f4a5b5a841f2763dc3062bf29212606a97f5a7a675f3'
          when '0.6.2' then '3089f77fcdb922894456ea6d0bc78a2fb60984d1d3687fa9d8f604b266c83446'
          when '0.6.3' then '6dff4ffc61d66aacd627a176737b8725624718a9e68cc81460a3df9b241c7932'
          when '0.6.4' then '75422bbd26107cfc5dfa7bbb65c1d8540a5193796b5c6b272d8d70b094b26488'
          when '0.7.0' then '74111674527c5be0db7a98600df8290395abdd94e2cd86bda7418d748413396d'
          when '0.7.1' then '9b3a199779a0d9b92266fae2abd7ed91c18ba437eba46e76114cd1940b3b7741'
          when '0.7.2' then '4403357fbfddbcdd0742946cab7856638cb0f15898c75d79d155753621d60b0c'
          when '0.7.3' then '08dd9af590a6c6ecd629e532083bd898b42c6425d08aa9f62b8f090a6dd65826'
          when '0.7.4' then 'a66cd4efdff376e7fd5c22d2710d7ef6734562c46df80a05e3144222965d9a97'
          when '0.7.5' then '60c1685bfbefe55d0ac67f37d4bc88752a204609221d0cc4425452f1ffc2e42b'
          when '0.8.1' then 'd4d4e865e760df499a3ea884fa73ff5fc11a42ce23108c5ce0eb0eb80dafcb75'
          when '0.8.2' then '63de23c7de3b9b48592353f8427ad40a9dd28da51a66c9f3759f5fdfd6aad136'
          when '0.8.3' then '97102020bd3638e98d65633d0e51d425168de17a53f12d566585663a2a19905f'
          when '0.8.4' then '913f0e5b2af39f09c6579035d0bb7f002589377bd86e2e886df37f1ecbc25906'
          when '0.8.5' then 'cfef78ea3c0b28afe51f7ef0f7663e323398f3311ae4ce760546854991dbdb16'
          when '0.9.0' then '0bf2cee6d7c8eb3ce5bb6a868907d845a0b9fd83655146b9dd17dc530e6a7ef5'
          when '0.9.1' then 'd035207b84c8bd4cdc252b01053d2126b6194e7961a130b11407e6e3a66e4b0e'
          when '0.9.2' then 'e54ef843a82defe4fff9042c5ba953ba6fb510241253fe51d410cf0f95e86d9f'
          when '0.9.3' then 'd5ee6bd737463f211c0e99f71b33c5382dcad27ecf13affb82e4c1314bd8656a'
          end
        when 'darwin-i386'
          case resource.version
          when '0.6.0' then '95d57bfcc287bc344ec3ae8372cf735651af1158c5b1345e6f30cd9a9c811815'
          when '0.6.1' then '41dfcc0aefe0a60bdde413eaa8a4a0c98e396d6b438494f1cf29b32d07759b8e'
          when '0.6.2' then '973105816261c8001fcfa76c9fb707fa56325460476fb0daa97b9ece0602a918'
          when '0.6.3' then '7fb30756504cd9559c9b23e5d0d8d73a847ee62ed85d39955b5906c2f59a5bc1'
          when '0.6.4' then '4cd39e968ca6bed0888f831a2fc438ffe0b48dab863c822e777f5b5219bacf5c'
          when '0.7.0' then '16ab91969c9b268ccae532070221b6c4fecaad298e4662a46cdfe9847c80dd3f'
          when '0.7.1' then '668b0a5c577fc717de710391fa509a820c5640d73ab3b232023fc351e6084c36'
          when '0.7.2' then '23e6e8dd14c2be02fd095a865edd1725f5ccdbce1109ad5f70832866012d1d7f'
          when '0.7.3' then 'cf369542e30c5aa22967459b25fec284284d292ff25e801bdcd1a5f37f1a5143'
          when '0.7.4' then '7638e80c9db050ef8d63bad3baa338985da1a1bd4657f3b2fc4222d105c673a3'
          when '0.7.5' then '9ff8798a94bab99fb2387afae5bc0fc2844a304675abbceb9315292019a8f582'
          when '0.8.1' then '7e07930dd7085db838feabc8cdf0a9e6668eddc1b7db6496192a966a9548e447'
          when '0.8.2' then '43de9c5f42e548ca821e2a786988ca5f98b506ae8c26e3e3d3159935f775809c'
          when '0.8.3' then '6a088c90282c1aa45f727357631c377dd1370169d2baa79f317256caf3fd5230'
          when '0.8.4' then '3e635e6d961ebbeaecbd651e22dc009445d5c13402d2c127eb71f8a69eb41cea'
          when '0.8.5' then '2f13a389405724597c97d3e738fcd3350512f3417a5520c21f9b36d06765c4e1'
          when '0.9.0' then 'a7b9fac9429e35b393d9f7e7b3b65dccb920a5dc3589c600ed6aa552ab30e8c8'
          when '0.9.1' then '4d20daad49708f17515d5d2b89c731d88253f53b8aa578fca7e7c135be6603a2'
          when '0.9.2' then '0d76287f9ba23b5dca2e449b1fff6fa95ebd4c2420014d6bbb80fb9557a62455'
          when '0.9.3' then 'bcca7910f661628baba1ecc44ca90cbb6ed1b8ccad016fa29784f047dcbadda0'
          end
        when 'solaris-amd64'
          case resource.version
          when '0.6.2' then 'f5655f0b173e5d51c5b92327d1fc7f24ac0939897a1966da09146e4eb75af9d1'
          when '0.6.3' then 'e6a286ff17a2345b8800732850eadb858b3dba9486355e1164a774ccec2f0e98'
          when '0.6.4' then 'c26a64310f83c3ba388c78d5b89d640d961ae9eabe221c244bfffcfa753966bd'
          when '0.7.0' then '0f1db173a95861bc84940b4dcdb2debfbfbc18f2b50e651d0e23dfda331018ea'
          when '0.7.1' then '9c77c5c904dce4832b9e7dede2cdc5f42f5fb360885583bc414fee868aed5cb9'
          when '0.7.2' then 'f1ccaf9d9dd62544323e130cee7221df2a6d4b577e9e4a120db357e59782f12d'
          when '0.7.3' then '49b13f83f8099537e72adc1bb34b6cb70b3699aa10245db4b8ef1f48c6e0b007'
          when '0.7.4' then '0300ffa4d1007b00bca37112cf934d3e281afdc300ce336735bbf3a33ebcfc19'
          when '0.7.5' then 'aa3705a958d0403e2ddacaa75c1d3ede5f290b0ef3a60e6e24976f2d8f32d840'
          when '0.8.1' then '67862913dae4dd968e7219aec2122d6e7a20dd42537e137c648d0a53f17c4c9e'
          when '0.8.2' then '393f11abaa19c39b122049c3d8672d672c23ec6916a11234470aa5002c8cd4f7'
          when '0.8.3' then '22a5b2eb89f6492a54e42fafee958f862baa6962d52d45974c77f62951b4ba0e'
          when '0.8.4' then '3d54a8af4b7de9d83b49019399ff2f69b45a35b94b5a0f9f82dda944e9ce48be'
          when '0.8.5' then '6d05136a9c64a6ec6bffc10f3c8e57e944930eeb609dedd7e6c5f81fc81e1eee'
          when '0.9.0' then '859d5282549bdf3e38ff24c3c33c0a2b9a4016f58fc4050ae64e6bf75e110d0d'
          when '0.9.1' then '7d93e50bbf0abd1fc2cac141981c3b476c9cba3b303b37f08f35977241b0716a'
          when '0.9.2' then '1e07fe2f71afee5c581c9b1e9a836c91ce4bbec5003d9c3fe426995d2233def8'
          when '0.9.3' then '75dffd24347397fb4abf82291486ff8773f53dc48725ac5a78accba492f8cf38'
          end
        when 'windows-amd64'
          case resource.version
          when '0.6.0' then '182beea0d8d346a9bfd70679621a5542aeeeea1f35be81fa3d3aeec2479bac3d'
          when '0.6.1' then '2be6b0f0fdebff00aea202e9846131af570676f52e2936728cbf29ffbb02f57f'
          when '0.6.2' then 'df3234fb7def7138b7cb8c73fe7c05942ec1e485925701a7b38fc7e2396a212f'
          when '0.6.3' then '04cd1fdc9cd3a27ffc64e312e40142db7af0d240608f8080ec6d238294b20652'
          when '0.6.4' then '1ca3cc2943b27ec8968665efce1122d4ea355ccbde5b4807753af71f11190a9b'
          when '0.7.0' then 'ac5973a58dd9c6f52c784a7106a29adcf7c94015036538155b6c0ee7efc3a330'
          when '0.7.1' then '71a4e073cbab336c0becb5c17a0173fdae56480558564138353dc0b89e989d82'
          when '0.7.2' then '7a5ec31018328a3764f22327c940765c9cd99e57c6759fc43fbfed8318d5e379'
          when '0.7.3' then 'ec80a931603bf585704e338e6cb497af9aa58ebdae5e3442a3f78f7027d80b66'
          when '0.7.4' then 'c2e071ebae166d4cfdf894966b2966026cf9175d394001704f68bcbccaa8e446'
          when '0.7.5' then '6cc64b1bb949f926d403e0436d02bf740844cf268076cf6d3d345361c1aa5293'
          when '0.8.1' then 'ea5475b9421dc93383480c622936203eb1b457ff6c96a11e10d65f1aaa061bff'
          when '0.8.2' then 'e3def6d26c26937a5c33327ff2884322aa12bdd29235335d877864e05a12fb52'
          when '0.8.3' then '9fea45cbe7e55bb94b3d7fb4c8f0527ba36c79029eb1369ace0d45d9546d158a'
          when '0.8.4' then 'd320721e5e65bbf96d83feeb7f7dead5b498ff21771e31ea4553adb11299b4fa'
          when '0.8.5' then '9ccccea7ecbbfedbceb0a6a0e4bbf3c07bcac14334c69faac42e5a9026471161'
          when '0.9.0' then 'c2bd9906b61290fa01ac236393cbfe2f3aadeec4b9ceee724c99217ccb1061ff'
          when '0.9.1' then '74bc3b131411fbcdc650542b94daa28838619c086617ab75c78504eef507e781'
          when '0.9.2' then '1126fc9841e295dfbdf0d4180336452545eee75b3f545d1c6a105ae8a8020a3c'
          when '0.9.3' then '7aaf4d944f77f1f4f9efee0b5e2f28fbd89a83f3fc65ee5dd68a998d6ecda08e'
          end
        when 'windows-i386'
          case resource.version
          when '0.5.0' then '7fd760ee8a5c2756391cacc1e924ae602b16cdad838db068e564f798383ad714'
          when '0.5.1' then 'bb9e1753cf793ad6f9db34bd6e18fb0fa5b0696a8a51a7f1c61484386dfe6682'
          when '0.5.2' then '2e866812de16f1a6138a0fd1eebc76143f1314826e3b52597a55ac510ae94be6'
          when '0.6.0' then '8379afd07668933c120880bba8228277e380abb14e07a6c45b94562ac19b37bd'
          when '0.6.1' then '10197d1f7be0d0087414c9965008ddd88e9fcd9ac9d5bd02d72d65eda36f5834'
          when '0.6.2' then 'f072d89c098dde143897e653d5adaf23125b58062344ef4be4029d635f959654'
          when '0.6.3' then '55733a730c5055d0ed1dc2656b2b6a27b21c7c361a907919cfae90aab2dff870'
          when '0.6.4' then '6555f0fff6c3f9ea310c94a73365d9892afc255efb47c85041ad1c0ede854b87'
          when '0.7.0' then 'd0ddfe7d1de9879f02b0d110e45bb74cd5028a2910bcac8b2629d0659367cd96'
          when '0.7.1' then 'ad7b76ac8660c7417bbdccbe1905942fa2fcc4c53a093d7b2d64497bdf4fc315'
          when '0.7.2' then 'c041dc43995df3505d9146e3a2f532bfc491c49fb644bd1e2ceead7d7dc3011c'
          when '0.7.3' then '87a7169bd5298e179a3bbd2f30b3447c09023dc771c97d083779090655bf0a5f'
          when '0.7.4' then 'ede957f736758a40fb8e3e33eb423a71226db46085fe1507d880a0ce393e9658'
          when '0.7.5' then '7ea88aa53026cb14bab6a68d5b64c43515ea39552594ae399978fc13bcd74707'
          when '0.8.1' then '175b63438846fbf800394d00cba1f966c16e967c3ebbf99cf8f3df8fa14ca84f'
          when '0.8.2' then '98d840c42e255e1d6011e601bcb1a86b0133e381ce836b4d97e92d9d3c882c8b'
          when '0.8.3' then 'c9a6f92b34eab0ceec854830af4c906339737c0df0f4875c03da9ac7031fe56e'
          when '0.8.4' then '419d81b6ec7c1f94f495a43becdca7243b33ca9168d6107e3475d5e7c5392f48'
          when '0.8.5' then '13b42f20bed1028deec9e272698b65866e187fe26b13b2735f0238b37a1d44b5'
          when '0.9.0' then '2ec01564ab08d213169caa1a8e2beb329f7f45339d43e231e0f2b77159568f3c'
          when '0.9.1' then '047117cc205b4541162177684fc1b0f1e6f62b7cae7ea0a3c17ce85afd82df97'
          when '0.9.2' then 'cdeca9c765e6f43543b229c95c5376b9d60c8ab3b1a790ba94b80cfa1b41ffd5'
          when '0.9.3' then '2596b26b084b7a91ca1c165419fe81af5058e82bc1f88bffe23402e61813cdbe'
          end
        when 'linux-amd64'
          case resource.version
          when '0.5.0' then '161f2a8803e31550bd92a00e95a3a517aa949714c19d3124c46e56cfdc97b088'
          when '0.5.1' then '967ad75865b950698833eaf26415ba48d8a22befb5d4e8c77630ad70f251b100'
          when '0.5.2' then '171cf4074bfca3b1e46112105738985783f19c47f4408377241b868affa9d445'
          when '0.6.0' then '307fa26ae32cb8732aed2b3320ed8daf02c28b50d952cbaae8faf67c79f78847'
          when '0.6.1' then 'dbb3c348fdb7cdfc03e5617956b243c594a399733afee323e69ef664cdadb1ac'
          when '0.6.2' then '7234eba9a6d1ce169ff8d7af91733e63d8fc82193d52d1b10979d8be5c959095'
          when '0.6.3' then 'b0532c61fec4a4f6d130c893fd8954ec007a6ad93effbe283a39224ed237e250'
          when '0.6.4' then 'abdf0e1856292468e2c9971420d73b805e93888e006c76324ae39416edcf0627'
          when '0.7.0' then 'b350591af10d7d23514ebaa0565638539900cdb3aaa048f077217c4c46653dd8'
          when '0.7.1' then '5dbfc555352bded8a39c7a8bf28b5d7cf47dec493bc0496e21603c84dfe41b4b'
          when '0.7.2' then 'aa97f4e5a552d986b2a36d48fdc3a4a909463e7de5f726f3c5a89b8a1be74a58'
          when '0.7.3' then '901a3796b645c3ce3853d5160080217a10ad8d9bd8356d0b73fcd6bc078b7f82'
          when '0.7.4' then '23a61773bee9b29198cc1f8fe2e62c320f82f95006ff70840c15c1e58eead73b'
          when '0.7.5' then '40ce7175535551882ecdff21fdd276cef6eaab96be8a8260e0599fadb6f1f5b8'
          when '0.8.1' then '74cdd7ad458aa63192222ad2bd14178fc3596d4fd64d12a80520d4e6f93eaf34'
          when '0.8.2' then '6409336d15baea0b9f60abfcf7c28f7db264ba83499aa8e7f608fb0e273514d9'
          when '0.8.3' then 'f894383eee730fcb2c5936748cc019d83b220321efd0e790dae9a3266f5d443a'
          when '0.8.4' then 'c8859a0a34c50115cdff147f998b2b63226f5f052e50f342209142420d1c2668'
          when '0.8.5' then '35dc317c80862c306ea5b1d9bc93709483287f992fd0797d214d1cc1848e7b62'
          when '0.9.0' then '33e54c7d9a93a8ce90fc87f74c7f787068b7a62092b7c55a945eea9939e8577f'
          when '0.9.1' then 'e997b87e70dc0f4996d7c5ac89f4776a8569ca99c00e5c8b8a0e0eb1042a9d30'
          when '0.9.2' then '0a2921fc7ca7e4702ef659996476310879e50aeeecb5a205adfdbe7bd8524013'
          when '0.9.3' then '9c6d652d772478d9ff44b6decdd87d980ae7e6f0167ad0f7bd408de32482f632'
          end
        when 'linux-i386'
          case resource.version
          when '0.5.0' then '4b6147c30596a30361d4753d409f8a1af9518f54f5ed473a4c4ac973738ac0fd'
          when '0.5.1' then 'dad93a02c01de885daee191bcc5a05ca2bf106200da61db33694a658432d8399'
          when '0.5.2' then '29306ce398109f954ceeea3af79878be4fb0d949f8af3a27c95ccef2101e8f60'
          when '0.6.0' then 'f58f3f03a8b48d89bb8be94a6d1767393ad2a410c920b064066e01c7fa24f06c'
          when '0.6.1' then '34b8d4a2a9ec85082b6e93c6785ba9c54663fec414062e45dd4386db46a533c4'
          when '0.6.2' then '500ac8c75768b7f2d63521d2501ff8cc5fb7f9ddf6c550e9449364810c96f419'
          when '0.6.3' then '2afb65383ab913344daaa9af827c1e8576c7cae16e93798048122929b6e4cc92'
          when '0.6.4' then 'dbaf5ad1c95aa7dce1625d61b6686d3775e53cb3e7d6c426d29ea96622d248a8'
          when '0.7.0' then 'babf618b1f10455b4ab65b91bdf5d5a7be5bfbb874ce41e8051caca884c43378'
          when '0.7.1' then '7a391a9adc251a5889405eab5512668b77e6ac0f7d818852928735fa82e8abad'
          when '0.7.2' then '43b22bcd04e74445c3ea6c143b3acbfe5546d6792c28d123ef5832cd8f96162f'
          when '0.7.3' then 'b15e96a1b5833b08d785d67b8f2465a9a0185e34149855943717dd818b347750'
          when '0.7.4' then '7fe40af0825b2c6ab6c7e4e3e7d68471cccbd54f9a1513ad622b832cfda5fa07'
          when '0.7.5' then '8abf0189776ecc5c8746e12021b6cfe6d96e0b4689ce4a4948b7e3faa07f3025'
          when '0.8.1' then '76b4a6a39a3299ceb9228bc5e37a6b8a968dc2635a9d72030a047ccff0388886'
          when '0.8.2' then 'f60237e24e4f03d8f7fd8a4e31cb246c701c41beb7cb7d1735320a5aa0b331c8'
          when '0.8.3' then 'f4c6cdf82de7aacbac1590d46f755ddb4861894cc78753a9b29ef351abaa748c'
          when '0.8.4' then 'e58abbfedc4bebb66476448ec0fccda37be1c911c05017d7cd597db6384cd531'
          when '0.8.5' then 'b1a7c51834178e1cdc38e7377789c23452b77e1861cfedfc2601fa78e914e46d'
          when '0.9.0' then '7f4c537ef333ed93d934b7e0bdb3b16949ae50f4071df16894530e24b9e9d927'
          when '0.9.1' then '5143f419b4ba67b6c4fdd023a26a6563f0a7cf47909e648e490ef552caf03f65'
          when '0.9.2' then '966b5ae4f149aa1982b037fb5343f4c43f6167b64d09fd01cbd0b5aa13db421a'
          when '0.9.3' then 'a39eb7e844cbd5daff04f7aff88c18daa1db7a555d476b1475904bc5f5c7036d'
          end
        when 'linux-arm'
          case resource.version
          when '0.6.0' then '425e7332789deb446a486ac25f7143aba5f16453ac46ede39b71ab6a361d8726'
          when '0.6.1' then '5b61e9ed10e02990aa8a2a0116c398c61608bc7f5051cb5a13750ffd47a54d51'
          when '0.6.2' then 'b6b4f66f6dd8b1d4ebbd0339f4ed78c4853c7bd0d42fd15af70179b5bc65482e'
          when '0.6.3' then 'c5fd5278be2757d2468bc7e263af15bc9a9e80fc5108fec658755804ea9bca56'
          when '0.6.4' then '81200fc8b7965dfc6048c336925211eaf2c7247be5d050946a5dd4d53ec9817e'
          when '0.7.0' then '7c9ee149d66d14cc8aa81b8d86e7df5a27876216578ab841ab3921e7f4a0ce4b'
          when '0.7.1' then 'e7b6846fb338c31e238f9b70cc42bd35f7de804cc31d2d91fe23cbe5de948aae'
          when '0.7.2' then 'e18934a3a38b980bc0cfaa8d74379a6bfe58cf1ecf4b164e28ff37dd6c7198b0'
          when '0.7.3' then 'a2d2d2cf194e3768aae7c3cdf140a056bf2534f4c83fb7a66cfbd4090c98773e'
          when '0.7.4' then 'bfd9cbef9c7c9f2128704940323d1727d8edbbd595c8d82aba923e04f04b266d'
          when '0.7.5' then 'df4bc38eff4305632d29c5650fbb7e7ff97b8ef12a964fd8ee5f691849c51711'
          when '0.8.1' then '552aa077ffbe6a52bf38d8feca5803a813a7a3986e4cb6efda61dad4480642c1'
          when '0.8.2' then '02b63410a8c46bab0713615c126eb1530945ebfac3340bcb748d12cb1ab6db8c'
          when '0.8.3' then 'a650c9a973fb34c23328f717a6bd5fe6bc22ac3b9e15013649c720d87dce90d4'
          when '0.8.4' then 'ce9914f75df068930fc78cb99ddcad7e4c298a385a5fa3686b2d9d4ea1044945'
          when '0.8.5' then '59d14c76f808a1d41647e2d772ce1fe0d4a522836af238faa4894f7e076b1b03'
          when '0.9.0' then '35a35db51af51cfbdf6ee67e3d0311c7823cfe17a55f0babccb0d58ee6a344ff'
          when '0.9.1' then '393347d27cfc9362b17c92099296f09acfc7ac2b7671b05350d1aa960dd85086'
          when '0.9.2' then '15c556b1b66d3fe80837898c85628e7ee5eadcb3a86cb4814a4eda072e6d7c29'
          when '0.9.3' then '068c9c20f15fe348e9ac36081e0c87d12fcc650c60638ea3f87e299b24b1cd6a'
          end
        end
      end
    end
  end
end
