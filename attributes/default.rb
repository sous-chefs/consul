#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#

# Only used on Linux
default['consul']['service_name'] = 'consul'
default['consul']['service_user'] = 'consul'
default['consul']['service_group'] = 'consul'

default['consul']['config']['bag_name'] = 'secrets'
default['consul']['config']['bag_item'] = 'consul'

default['consul']['config']['path'] = join_path config_prefix_path, 'consul.json'
default['consul']['config']['data_dir'] = data_path
default['consul']['config']['ca_file'] = join_path config_prefix_path, 'ssl', 'CA', 'ca.crt'
default['consul']['config']['cert_file'] = join_path config_prefix_path, 'ssl', 'certs', 'consul.crt'
default['consul']['config']['key_file'] = join_path config_prefix_path, 'ssl', 'private', 'consul.key'

default['consul']['config']['client_addr'] = '0.0.0.0'
default['consul']['config']['ports'] = {
  'dns'      => 8600,
  'http'     => 8500,
  'rpc'      => 8400,
  'serf_lan' => 8301,
  'serf_wan' => 8302,
  'server'   => 8300
}

default['consul']['diplomat_version'] = nil

default['consul']['service']['config_dir'] = join_path config_prefix_path, 'conf.d'

default['consul']['service']['install_path'] = windows? ? config_prefix_path : '/srv'
default['consul']['service']['install_method'] = 'binary'
default['consul']['service']['binary_url'] = "https://releases.hashicorp.com/consul/%{version}/%{filename}.zip" # rubocop:disable Style/StringLiterals

default['consul']['service']['source_url'] = 'https://github.com/hashicorp/consul'

default['consul']['version'] = '0.6.3'

# Windows only
default['consul']['service']['nssm_params'] = {
  'AppDirectory'     => data_path,
  'AppStdout'        => join_path(config_prefix_path, 'stdout.log'),
  'AppStderr'        => join_path(config_prefix_path, 'error.log'),
  'AppRotateFiles'   => 1,
  'AppRotateOnline'  => 1,
  'AppRotateBytes'   => 20_000_000
}

default['consul']['checksums'] = {
  'consul_0.5.0_darwin_amd64'  => '24d9758c873e9124e0ce266f118078f87ba8d8363ab16c2e59a3cd197b77e964',
  'consul_0.5.0_linux_386'     => '4b6147c30596a30361d4753d409f8a1af9518f54f5ed473a4c4ac973738ac0fd',
  'consul_0.5.0_linux_amd64'   => '161f2a8803e31550bd92a00e95a3a517aa949714c19d3124c46e56cfdc97b088',
  'consul_0.5.0_windows_386'   => '7fd760ee8a5c2756391cacc1e924ae602b16cdad838db068e564f798383ad714',
  'consul_0.5.0_web_ui'        => '0081d08be9c0b1172939e92af5a7cf9ba4f90e54fae24a353299503b24bb8be9',

  'consul_0.5.1_darwin_amd64'  => '06fef2ffc5a8ad8883213227efae5d1e0aa4192ccb772ec6086103a7a08fadf8',
  'consul_0.5.1_linux_386'     => 'dad93a02c01de885daee191bcc5a05ca2bf106200da61db33694a658432d8399',
  'consul_0.5.1_linux_amd64'   => '967ad75865b950698833eaf26415ba48d8a22befb5d4e8c77630ad70f251b100',
  'consul_0.5.1_windows_386'   => 'bb9e1753cf793ad6f9db34bd6e18fb0fa5b0696a8a51a7f1c61484386dfe6682',
  'consul_0.5.1_web_ui'        => 'ad883aa52e1c0136ab1492bbcedad1210235f26d59719fb6de3ef6464f1ff3b1',

  'consul_0.5.2_darwin_amd64'  => '87be515d7dbab760a61a359626a734f738d46ece367f68422b7dec9197d9eeea',
  'consul_0.5.2_linux_386'     => '29306ce398109f954ceeea3af79878be4fb0d949f8af3a27c95ccef2101e8f60',
  'consul_0.5.2_linux_amd64'   => '171cf4074bfca3b1e46112105738985783f19c47f4408377241b868affa9d445',
  'consul_0.5.2_windows_386'   => '2e866812de16f1a6138a0fd1eebc76143f1314826e3b52597a55ac510ae94be6',
  'consul_0.5.2_web_ui'        => 'ad883aa52e1c0136ab1492bbcedad1210235f26d59719fb6de3ef6464f1ff3b1',

  'consul_0.6.0_darwin_386'    => '95d57bfcc287bc344ec3ae8372cf735651af1158c5b1345e6f30cd9a9c811815',
  'consul_0.6.0_darwin_amd64'  => '29ddff01368458048731afa586cec5426c8033a914b43fc83d6442e0a522c114',
  'consul_0.6.0_freebsd_386'   => 'c5eb9f5c211612148e1e1cd101670fd08fd1abf9b2e541ac2936ab9637626249',
  'consul_0.6.0_freebsd_amd64' => 'd7be5c95b971f48ccbd2c53c342dced9a3d0a5bc58f57b4f2e75672d96929923',
  'consul_0.6.0_freebsd_arm'   => '92f29ad00f8f44d3be43b3b038a904c332757eb2a6848a7d6754583c2791e18b',
  'consul_0.6.0_linux_386'     => 'f58f3f03a8b48d89bb8be94a6d1767393ad2a410c920b064066e01c7fa24f06c',
  'consul_0.6.0_linux_amd64'   => '307fa26ae32cb8732aed2b3320ed8daf02c28b50d952cbaae8faf67c79f78847',
  'consul_0.6.0_linux_arm'     => '425e7332789deb446a486ac25f7143aba5f16453ac46ede39b71ab6a361d8726',
  'consul_0.6.0_windows_386'   => '8379afd07668933c120880bba8228277e380abb14e07a6c45b94562ac19b37bd',
  'consul_0.6.0_windows_amd64' => '182beea0d8d346a9bfd70679621a5542aeeeea1f35be81fa3d3aeec2479bac3d',
  'consul_0.6.0_web_ui'        => '73c5e7ee50bb4a2efe56331d330e6d7dbf46335599c028344ccc4031c0c32eb0',

  'consul_0.6.1_darwin_386'    => '41dfcc0aefe0a60bdde413eaa8a4a0c98e396d6b438494f1cf29b32d07759b8e',
  'consul_0.6.1_darwin_amd64'  => '358654900772b3477497f4a5b5a841f2763dc3062bf29212606a97f5a7a675f3',
  'consul_0.6.1_freebsd_386'   => '87d8c56c0c02e2fcde5192614dff9c491af93f7186fd55caae3fbe2c4d6ca80c',
  'consul_0.6.1_freebsd_amd64' => '04688dfabedf6ded7f3d548110c7d9ffc8d6d3a091062593e421702bc42b465d',
  'consul_0.6.1_freebsd_arm'   => '7b907fbd4377671de1be2dc0c19f955e1b37cd862c1af8251e9bf6d668b0d3a8',
  'consul_0.6.1_linux_386'     => '34b8d4a2a9ec85082b6e93c6785ba9c54663fec414062e45dd4386db46a533c4',
  'consul_0.6.1_linux_amd64'   => 'dbb3c348fdb7cdfc03e5617956b243c594a399733afee323e69ef664cdadb1ac',
  'consul_0.6.1_linux_arm'     => '5b61e9ed10e02990aa8a2a0116c398c61608bc7f5051cb5a13750ffd47a54d51',
  'consul_0.6.1_windows_386'   => '10197d1f7be0d0087414c9965008ddd88e9fcd9ac9d5bd02d72d65eda36f5834',
  'consul_0.6.1_windows_amd64' => '2be6b0f0fdebff00aea202e9846131af570676f52e2936728cbf29ffbb02f57f',
  'consul_0.6.1_web_ui'        => 'afccdd540b166b778c7c0483becc5e282bbbb1ee52335bfe94bf757df8c55efc',

  'consul_0.6.2_darwin_386'    => '973105816261c8001fcfa76c9fb707fa56325460476fb0daa97b9ece0602a918',
  'consul_0.6.2_darwin_amd64'  => '3089f77fcdb922894456ea6d0bc78a2fb60984d1d3687fa9d8f604b266c83446',
  'consul_0.6.2_freebsd_386'   => 'fc87f2ddd2090031e79136954d9e3f85db480d5ed9eba6ae627bf460e4c95e6e',
  'consul_0.6.2_freebsd_amd64' => '1ccf96cb58c6fa927ee21c24d9be368ebe91559ed32626a89a715a3781659e3f',
  'consul_0.6.2_freebsd_arm'   => '30d8d09dd88cdd8d5256cea445fd0fed787d73cc6585e2eef7212161f29c8053',
  'consul_0.6.2_linux_386'     => '500ac8c75768b7f2d63521d2501ff8cc5fb7f9ddf6c550e9449364810c96f419',
  'consul_0.6.2_linux_amd64'   => '7234eba9a6d1ce169ff8d7af91733e63d8fc82193d52d1b10979d8be5c959095',
  'consul_0.6.2_linux_arm'     => 'b6b4f66f6dd8b1d4ebbd0339f4ed78c4853c7bd0d42fd15af70179b5bc65482e',
  'consul_0.6.2_solaris_amd64' => 'f5655f0b173e5d51c5b92327d1fc7f24ac0939897a1966da09146e4eb75af9d1',
  'consul_0.6.2_windows_386'   => 'f072d89c098dde143897e653d5adaf23125b58062344ef4be4029d635f959654',
  'consul_0.6.2_windows_amd64' => 'df3234fb7def7138b7cb8c73fe7c05942ec1e485925701a7b38fc7e2396a212f',
  'consul_0.6.2_web_ui'        => 'f144377b8078df5a3f05918d167a52123089fc47b12fc978e6fb375ae93afc90',

  'consul_0.6.3_darwin_386'    => '7fb30756504cd9559c9b23e5d0d8d73a847ee62ed85d39955b5906c2f59a5bc1',
  'consul_0.6.3_darwin_amd64'  => '6dff4ffc61d66aacd627a176737b8725624718a9e68cc81460a3df9b241c7932',
  'consul_0.6.3_freebsd_386'   => '4a1aa8f570852eb238b7406172c097f5b32f41a3f01186111e576faa7506248c',
  'consul_0.6.3_freebsd_amd64' => '8bdf2da41e6118af18af9aba0a127d4abb3453a20a9064e1bd1206f5c11ac2c8',
  'consul_0.6.3_freebsd_arm'   => '5452d29f1cf0720c4ae0e0ec1cc5e44b0068a0340a6b61ab5ec245fa0f3447ad',
  'consul_0.6.3_linux_386'     => '2afb65383ab913344daaa9af827c1e8576c7cae16e93798048122929b6e4cc92',
  'consul_0.6.3_linux_amd64'   => 'b0532c61fec4a4f6d130c893fd8954ec007a6ad93effbe283a39224ed237e250',
  'consul_0.6.3_linux_arm'     => 'c5fd5278be2757d2468bc7e263af15bc9a9e80fc5108fec658755804ea9bca56',
  'consul_0.6.3_solaris_amd64' => 'e6a286ff17a2345b8800732850eadb858b3dba9486355e1164a774ccec2f0e98',
  'consul_0.6.3_windows_386'   => '55733a730c5055d0ed1dc2656b2b6a27b21c7c361a907919cfae90aab2dff870',
  'consul_0.6.3_windows_amd64' => '04cd1fdc9cd3a27ffc64e312e40142db7af0d240608f8080ec6d238294b20652',
  'consul_0.6.3_web_ui'        => '93bbb300cacfe8de90fb3bd5ede7d37ae6ce014898edc520b9c96a676b2bbb72'
}
