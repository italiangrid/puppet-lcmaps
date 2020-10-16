type Lcmaps::PoolData = Struct[{
  name       => String,
  size       => Integer,
  base_uid   => Integer,
  group      => String,
  groups     => Array[String],
  gid        => Integer,
  vo         => String,
  role       => Optional[String],
  capability => Optional[String],
}]
