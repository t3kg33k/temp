import os

def get_average_file_size_gb(directory):
    """
    Calculates the average file size in gigabytes for files in a directory.

    Args:
        directory (str): The path to the directory.

    Returns:
        float: The average file size in gigabytes, or 0 if no files are found.
    """
    total_size_bytes = 0
    file_count = 0
    for filename in os.listdir(directory):
        filepath = os.path.join(directory, filename)
        if os.path.isfile(filepath):
            total_size_bytes += os.path.getsize(filepath)
            file_count += 1

    if file_count == 0:
        return 0

    average_size_bytes = total_size_bytes / file_count
    average_size_gb = average_size_bytes / (1024 ** 3)
    return average_size_gb

if __name__ == "__main__":
    directory_path = input("Enter the directory path: ")
    if os.path.exists(directory_path) and os.path.isdir(directory_path):
      average_size = get_average_file_size_gb(directory_path)
      print(f"The average file size in {directory_path} is: {average_size:.4f} GB")
    else:
      print("Invalid directory path.")
