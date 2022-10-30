execute as @a run function ftmc:elevator/v2/elev_v2_engine_inner

# Run a teleportation tick for every player who has his corresponding session (armor_stand entity).
# For those players in the session, their tags FtmcElev2GoUpwardCond and FtmcElev2GoDownwardCond will be overriden before the teleportation is executed.
function ftmc:elevator/v2/run_sessions
