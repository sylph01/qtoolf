$('.rounds.result').ready ->
  $('#load-scores').click ->
    $.ajax '/api/v1/rounds/' + gon.round_id,
      type: 'GET',
      dataType: 'json',
      success: (data, textStatus, jqXHR) ->
        threshold_rank = parseInt($('#threshold-rank').val())
        threshold_rate = parseInt($('#threshold-rate').val())
        rate_basis = parseInt($('#rate-basis').val())
        passed_by_rank =
          data.match_stats.filter((x) -> (x.rank <= threshold_rank)).sort((a, b) -> b.rate_against_1 - a.rate_against_1).map((x) -> x.name)
        passed_by_rate_against_1 =
          data.match_stats.filter((x) -> (x.rank > threshold_rank)).sort((a, b) -> b.rate_against_1 - a.rate_against_1).slice(0, threshold_rate).map((x) -> x.name)
        passed_by_rate_against_2 =
          data.match_stats.filter((x) -> (x.rank > threshold_rank)).sort((a, b) -> b.rate_against_2 - a.rate_against_2).slice(0, threshold_rate).map((x) -> x.name)
        if rate_basis == 1
          $('#passed').val(passed_by_rank.concat(passed_by_rate_against_1).join('\n'))
        else
          $('#passed').val(passed_by_rank.concat(passed_by_rate_against_2).join('\n'))

  $('#datatable').DataTable({
    ajax: {
      url: '/api/v1/rounds/' + gon.round_id,
      dataSrc: 'match_stats'
    },
    columns:[
      {data: 'name'},
      {data: 'genre'},
      {data: 'kind'},
      {data: 'score'},
      {data: 'rank'},
      {data: 'rate_against_1'},
      {data: 'rate_against_2'}
    ]
  })
