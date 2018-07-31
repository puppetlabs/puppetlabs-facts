# A plan that retrieves facts and stores in the inventory for the
# specified nodes.
#
# The $nodes parameter is a list of nodes to retrieve the facts for.
plan facts(TargetSpec $nodes) {
  $result_set = run_task('facts', $nodes, '_catch_errors' => true)

  $result_set.each |$result| {
    # Store facts for nodes from which they were succefully retrieved
    if ($result.ok) {
      add_facts($result.target, $result.value)
    }
  }

  return $result_set
}
