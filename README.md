# Dictionary Tool

A project for retrieving word definitions. This project includes a Python module for fetching definitions and tests to ensure the module works as expected.

## Project Structure

- `src/`: Contains the main source code of the project.
  - `pronun.py`: The script that provided the "how to say" the work and the first sentence of its definition 
  - `dictionary_tool.py`: Python module with the function to retrieve word definitions.
  - `test_dictionary_tool.py`: Test script to verify the functionality of the module.
- `requirements.txt`: List of dependencies required for the project.
- `Makefile`: File to automate common tasks such as installing dependencies, building the project, running tests, and creating packages.
- The bash scripts are 10x easier to do manually but I didnt add the makefile. 

## Requirements

- Python 3.6 or higher
- `pip`

## Setup

1. **Clone the Repository**

   ```sh
   git clone https://github.com/drykxs/pronun.git
   cd pronun

2. **Create and Activate a Virtual Environment**

   ```sh
   python3 -m venv venv
   source venv/bin/activate  # On Windows, use `venv\Scripts\activate`

3. **Install the requiriments**
   ```sh
   pip install -r requirements.txt

## Usage

**Running the Project**
To run the script:

```sh
python src/pronun.py
```

**Install Dependencies**

```sh
make 
```

**Clean Up**

```sh
make clean
```

## Contribution
Contributions are welcome! Please open an issue or a pull request if you find a bug or have suggestions for improvements.

## License
This project is licensed under the MIT License.

## Contact
For more information, contact drykxs@gmail.com.





