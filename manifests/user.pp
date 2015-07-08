define dspace::user($email, $first_name, $surname, $pass){
  $ds_runtime = hiera('ds::runtime')
  exec { "create_$email":
    command => "$ds_runtime/bin/dspace user -a -m $email -g ${first_name} -s ${surname} -p ${pass}",
    unless => "$ds_runtime/bin/dspace user -L | grep $email",
  }
}
