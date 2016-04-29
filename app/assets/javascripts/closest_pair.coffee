$(document).ready ->
  #Get Data
  dataset = $('.dataset').data('dataset')

  #Assign Labels
  labelSet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']
  label = {}
  i = 0
  while i < dataset.length
    x = dataset[i][0].toString()
    y = dataset[i][1].toString()
    label[x + y] = labelSet[i]
    i++

  #SVG Properties
  w = 500
  h = 300
  padding = 20

  #SVG Scales
  xScale = d3.scale.linear()
    .domain([0, d3.max(dataset, (d) -> d[0])])
    .range([padding, w - (padding * 2)])
  yScale = d3.scale.linear()
    .domain([0, d3.max(dataset, (d) -> d[1])])
    .range([h - padding, padding])
  rScale = d3.scale.linear()
    .domain([0, d3.max(dataset, (d) -> d[1])])
    .range([2, 5])

  #Draw SVG
  svg = d3.select('.graph').append('svg')
    .attr('width', w)
    .attr('height', h)
    .attr('margin', '10 10 10 10')
    .attr('display', 'block')

  #Draw Border
  borderPath = svg.append('rect')
    .attr('x', 0)
    .attr('y', 0)
    .attr('height', h)
    .attr('width', w)
    .style('stroke', 'black')
    .style('fill', 'none')
    .style('stroke-width', 10)

  #Draw Points
  svg.selectAll('circle').data(dataset).enter()
    .append('circle')
    .attr('cx', (d) -> xScale d[0])
    .attr('cy', (d) -> yScale d[1])
    .attr('r', 10)

  #Add Labels
  svg.selectAll('text').data(dataset).enter()
    .append('text').text((d) ->
      x = d[0].toString()
      y = d[1].toString()
      label[x + y])
    .attr('x', (d) -> xScale(d[0]) - 5).attr('y', (d) -> yScale(d[1]) + 5)
    .attr('font-family', 'sans-serif')
    .attr('font-size', '15px')
    .attr 'fill', 'white'
