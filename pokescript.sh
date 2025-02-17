# Comprobando que se haya ingresado la entrada
if [ -z "$1" ]; then
    echo "No se ingresó ningún Pokémon"
    exit 1
fi

pokemon=$1
url="https://pokeapi.co/api/v2/pokemon/$pokemon"
csv_file="pokemon.csv"

# Realizando la petición a la poke api
response=$(curl -s "$url")

# Verificando si la respuesta está vacía
if [ -z "$response" ]; then
    echo "Error: No se encontrón el pokemon: '$pokemon'"
    exit 1
fi

# Extrayendo los datos del Pokémon
id=$(echo "$response" | jq -r '.id')
name=$(echo "$response" | jq -r '.name')
weight=$(echo "$response" | jq -r '.weight')
height=$(echo "$response" | jq -r '.height')
order=$(echo "$response" | jq -r '.order')

# Imprimiendo los datos del pokemon 
echo "${name^} (No. $order)"
echo "Id = $id"
echo "Weight = $weight"
echo "Height = $height"

# Escribiendo en el archivo CSV
if [ ! -f "$csv_file" ]; then
    echo "id,name,weight,height,order" > "$csv_file"
fi
echo "$id,$name,$weight,$height,$order" >> "$csv_file"

