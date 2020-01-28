# A plan that retrieves facts and stores in the inventory for the
# specified targets.
#
# The $targets parameter is a list of targets to retrieve the facts for.
plan facts(TargetSpec $targets) {
  $result_set = run_task('facts', $targets)

  $result_set.each |$result| {
    add_facts($result.target, $result.value)
  }

  return $result_set
}
