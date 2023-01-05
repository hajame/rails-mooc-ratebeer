const BREWS = {}

const handleResponse = (breweries) => {
  BREWS.list = breweries
  BREWS.show()
}

const createTableRow = (brewery) => {
  const tr = document.createElement("tr")
  tr.classList.add("tablerow")
  const name = tr.appendChild(document.createElement("td"))
  name.innerHTML = brewery.name

  const founded = tr.appendChild(document.createElement("td"))
  founded.innerHTML = brewery.year

  const beerCount = tr.appendChild(document.createElement("td"))
  beerCount.innerHTML = brewery.beers.count

  const active = tr.appendChild(document.createElement("td"))
  active.innerHTML = brewery.active ? "active" : "retired"


  return tr
}

BREWS.show = () => {
  document.querySelectorAll(".tablerow").forEach((el) => el.remove())
  const table = document.getElementById("brewerylist")

  BREWS.list.forEach((beer) => {
    const tr = createTableRow(beer)
    table.appendChild(tr)
  })
}

BREWS.sortByName = () => {
  BREWS.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase())
  })
}
BREWS.sortByFounded = () => {
  BREWS.list.sort((a, b) => {
    return a.year - b.year
  })
}

BREWS.sortByBeerCount = () => {
  BREWS.list.sort((a, b) => {
    return a.beers.count - b.beers.count
  })
}

BREWS.sortByActive = () => {
  BREWS.list.sort((a, b) => {
    return Number(a.active) - Number(b.active)
  })
}

const breweries = () => {
  if (document.querySelectorAll("#brewerytable").length < 1) return

  document.getElementById("name").addEventListener("click", (e) => {
    e.preventDefault()
    BREWS.sortByName()
    BREWS.show()
  })

  document.getElementById("founded").addEventListener("click", (e) => {
    e.preventDefault()
    BREWS.sortByFounded()
    BREWS.show()
  })

  document.getElementById("beer_count").addEventListener("click", (e) => {
    e.preventDefault()
    BREWS.sortByBeerCount()
    BREWS.show()
  })

  document.getElementById("active").addEventListener("click", (e) => {
    e.preventDefault()
    BREWS.sortByActive()
    BREWS.show()
  })

  fetch("breweries.json")
    .then((response) => response.json())
    .then(handleResponse)
}

export { breweries }