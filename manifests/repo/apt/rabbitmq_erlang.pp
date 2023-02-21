# erlang erlang_solutions apt repo
class erlang::repo::apt::rabbitmq_erlang (
  String $ensure = $erlang::repo::apt::ensure,
  String $location    = 'https://ppa.launchpadcontent.net/rabbitmq/rabbitmq-erlang/ubuntu/',
  # jammy
  String $release     = downcase($facts['os']['distro']['codename']),
  String $repos       = 'contrib',
  String $key         = '0A9AF2115F4687BD29803A206B73A36E6026DFCA',
  String $key_source  =  "${location}{downcase($facts['os']['distro']['codename'])}Release.gpg",
  Optional[Variant[Numeric, String]] $pin = $erlang::package_apt_pin,
) inherits erlang {
  apt::source { 'erlang-rabbitmq_erlang':
    ensure   => $ensure,
    location => $location,
    release  => $release,
    repos    => $repos,
    key      => {
      'id'     => $key,
      'source' => $key_source,
    },
  }

  if $pin {
    apt::pin { 'erlang':
      packages => '*',
      priority => $pin,
      origin   => inline_template('<%= require \'uri\'; URI(@location).host %>'),
    }
  }
}
