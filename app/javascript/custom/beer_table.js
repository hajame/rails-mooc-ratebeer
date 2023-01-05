const BEERS = {}

const handleResponse = (beers) => {
  BEERS.list = beers
  BEERS.show()
}

const createTableRow = (beer) => {
  const tr = document.createElement("tr")
  tr.classList.add("tablerow")
  const name = tr.appendChild(document.createElement("td"))
  name.innerHTML = beer.name
  const style = tr.appendChild(document.createElement("td"))
  style.innerHTML = beer.style.beer_type
  const brewery = tr.appendChild(document.createElement("td"))
  brewery.innerHTML = beer.brewery.name

  return tr
}

BEERS.show = () => {
  document.querySelectorAll(".tablerow").forEach((el) => el.remove())
  const table = document.getElementById("beerlist")

  BEERS.list.forEach((beer) => {
    const tr = createTableRow(beer)
    table.appendChild(tr)
  })
}

BEERS.sortByName = () => {
  BEERS.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase())
  })
}

BEERS.sortByStyle = () => {
  BEERS.list.sort((a, b) => {
    return a.style.beer_type.toLowerCase().localeCompare(b.style.beer_type.toLowerCase())
  })
}

BEERS.sortByBrewery = () => {
  BEERS.list.sort((a, b) => {
    return a.brewery.name.toUpperCase().localeCompare(b.brewery.name.toUpperCase())
  })
}

const beers = () => {
  if (document.querySelectorAll("#beertable").length < 1) return

  document.getElementById("name").addEventListener("click", (e) => {
    e.preventDefault()
    BEERS.sortByName()
    BEERS.show()
  })

  document.getElementById("style").addEventListener("click", (e) => {
    e.preventDefault()
    BEERS.sortByStyle()
    BEERS.show()
  })

  document.getElementById("brewery").addEventListener("click", (e) => {
    e.preventDefault()
    BEERS.sortByBrewery()
    BEERS.show()
  })

  fetch("beers.json")
    .then((response) => response.json())
    .then(handleResponse)
}

export { beers }