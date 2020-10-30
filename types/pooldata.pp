type Lcmaps::PoolData = Struct[{
  name       => String,
  size       => Integer,
  base_uid   => Integer,
  group      => String,
  gid        => Integer,
  vo         => String,
  groups     => Optional[Array[String]],
  role       => Optional[String],
  capability => Optional[String],
}]
