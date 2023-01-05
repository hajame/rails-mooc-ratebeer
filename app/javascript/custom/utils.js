const BEERS = {}

const handleResponse = (beers) => {
  BEERS.list = beers
  BEERS.show()
}

BEERS.reverse = () => {
  BEERS.list.reverse()
}

const createTableRow = (beer) => {
  const tr = document.createElement("tr")
  const name = tr.appendChild(document.createElement("td"))
  name.innerHTML = beer.name
  const style = tr.appendChild(document.createElement("td"))
  style.innerHTML = beer.style.beer_type
  const brewery = tr.appendChild(document.createElement("td"))
  brewery.innerHTML = beer.brewery.name

  return tr
}

BEERS.show = () => {
  const table = document.getElementById("beerlist")

  BEERS.list.forEach((beer) => {
    const tr = createTableRow(beer)
    table.appendChild(tr)
  })
}

const beers = () => {
  fetch("beers.json")
    .then((response) => response.json())
    .then(handleResponse)
}

export { beers }