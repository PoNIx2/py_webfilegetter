import requests
import sys

def main():
    if len(sys.argv) > 1:
        url = sys.argv[1]
    else:
        url = input("Enter the URL of the file to download: ")
    try:
        response = requests.get(url)
        response.raise_for_status()  # Raise an error for bad responses
        filename = url.split("/")[-1]  # Get the filename from the URL
        # ダウンロードしたファイルがutf-8でなければ、utf-8に変換する
        content = response.content
        try:
            content.decode('utf-8')
        except UnicodeDecodeError:
            content = content.decode('shift_jis').encode('utf-8')
        with open(filename, 'wb') as file:
            file.write(content)
        print(f"File downloaded successfully as {filename}")
    except requests.exceptions.RequestException as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()