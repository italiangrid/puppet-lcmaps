type Lcmaps::PoolData = Struct[{
  name       => String,
  size       => Integer,
  base_uid   => Integer,
  group      => String,
  gid        => Integer,
  vo         => String,
  groups     => Optional[Array[String]],
  roles      => Optional[Array[String]],
  capability => Optional[String],
}]
