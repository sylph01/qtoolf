json.(@round, :id, :name)
json.event_id    @round.event.id
json.event_name  @round.event.name
json.matches     @round.matches, :id, :name
json.match_stats @stats
