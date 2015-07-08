define dspace::admin($email, $first_name, $surname, $pass){
  $ds_runtime = hiera('ds::runtime')

  exec { "create_$email":
    command => "$ds_runtime/bin/dspace create-administrator -e $email -f $first_name -l $surname -c eng -p $pass",
    unless => "$ds_runtime/bin/dspace user -L | grep $email",
  }
}
