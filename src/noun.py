import requests
import argparse

# Define your API key here
API_KEY = 'x'
BASE_URL = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"

def get_noun_definition(word):
    url = f"{BASE_URL}{word}?key={API_KEY}"
    response = requests.get(url)

    if response.status_code != 200:
        return f"Error: Unable to fetch definition (status code {response.status_code})"

    data = response.json()
    if not data:
        return f"No definition found for '{word}'"

    # Extract the noun pronunciation and definition
    for entry in data:
        if isinstance(entry, dict) and 'fl' in entry and entry['fl'] == 'noun' and 'shortdef' in entry:
            hw = entry['hwi']['hw'] if 'hwi' in entry and 'hw' in entry['hwi'] else word
            prs = entry['hwi']['prs'][0]['mw'] if 'prs' in entry['hwi'] and entry['hwi']['prs'] else ""
            definition = entry['shortdef'][0].split('.')[0] if entry['shortdef'] else "No definition available"
        return f"`{prs}` ({entry['fl']}): {definition}"

def main():
    parser = argparse.ArgumentParser(description='Query the Merriam-Webster dictionary for a noun pronunciation and definition.')
    parser.add_argument('word', type=str, help='The word to define')
    args = parser.parse_args()

    definition = get_noun_definition(args.word)
    print(definition)

if __name__ == "__main__":
    main()
