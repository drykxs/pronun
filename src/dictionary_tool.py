import requests
import argparse

# Define your API key here
API_KEY = '85e4ae07-9439-4e50-b352-3542ce427812'
BASE_URL = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"

def get_definition(word):
    url = f"{BASE_URL}{word}?key={API_KEY}"
    response = requests.get(url)

    if response.status_code != 200:
        return f"Error: Unable to fetch definition (status code {response.status_code})"

    data = response.json()
    if not data:
        return f"No definition found for '{word}'"

    # Extract the first definition
    if isinstance(data[0], dict) and 'shortdef' in data[0]:
        definitions = data[0]['shortdef']
        formatted_definitions = '\n'.join(definitions)
        return f"Definitions for '{word}':\n{formatted_definitions}"
    else:
        return f"No definition found for '{word}'"

def main():
    parser = argparse.ArgumentParser(description='Query the Merriam-Webster dictionary for a word definition.')
    parser.add_argument('word', type=str, help='The word to define')
    args = parser.parse_args()

    definition = get_definition(args.word)
    print(definition)

if __name__ == "__main__":
    main()
