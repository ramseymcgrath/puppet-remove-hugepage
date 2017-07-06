# Disables huge page deamon, and alters grub.conf to keep it disabled
#
# 
#
class remove_hugepage {

  augeas { 'grub.conf/no_khugepaged':
      incl    => '/etc/grub.conf',
      lens    => 'grub.lns',
      changes => [
          'setm title[*]/kernel/ transparent_hugepage never',
      ],
  }

  exec { 'disable_transparent_hugepage_enabled':
    command => '/bin/echo never > /sys/kernel/mm/transparent_hugepage/enabled',
    unless  => '/bin/grep -c \'\\[never\\]\' /sys/kernel/mm/transparent_hugepage/enabled 2>/dev/null',
  }

  exec { 'disable_transparent_hugepage_defrag':
    command => '/bin/echo never > /sys/kernel/mm/transparent_hugepage/defrag',
    unless  => '/bin/grep -c \'\\[never\\]\' /sys/kernel/mm/transparent_hugepage/defrag 2>/dev/null',
  }

}
