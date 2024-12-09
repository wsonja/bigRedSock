import requests
import base64
import io       
from PIL import Image

def upload_pinata(file):
    url = "https://api.pinata.cloud/pinning/pinFileToIPFS"
    jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySW5mb3JtYXRpb24iOnsiaWQiOiJkZTRjMTY2Mi0wNmYxLTQxYTQtOGQ0Zi1iNDZiOTA2Nzc3ZDAiLCJlbWFpbCI6InNldDgyQGNvcm5lbGwuZWR1IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsInBpbl9wb2xpY3kiOnsicmVnaW9ucyI6W3siZGVzaXJlZFJlcGxpY2F0aW9uQ291bnQiOjEsImlkIjoiRlJBMSJ9LHsiZGVzaXJlZFJlcGxpY2F0aW9uQ291bnQiOjEsImlkIjoiTllDMSJ9XSwidmVyc2lvbiI6MX0sIm1mYV9lbmFibGVkIjpmYWxzZSwic3RhdHVzIjoiQUNUSVZFIn0sImF1dGhlbnRpY2F0aW9uVHlwZSI6InNjb3BlZEtleSIsInNjb3BlZEtleUtleSI6IjBiMDgyYTVkOGQ4OWU1NDdiYTRkIiwic2NvcGVkS2V5U2VjcmV0IjoiNDgyM2ZjN2Q2MjUyNzhmZGY5ZDdkOTdkNTFmMGYzOTdhNzkzNzZkMzI2Y2EzZTNlYjQ5ZTM1MzUzY2Y5YjIzMSIsImV4cCI6MTc2NDk4NzgxMH0.XMnu-SvYkWkZouX1qvDQtkjgjMvSVRz0wvRf7qIjh-s"
    headers = {'Authorization': f'Bearer {jwt}'}

    response = requests.post(url, files={'file': file}, headers=headers)
    pinata_url = "ipfs.io/ipfs/" + response.json()['IpfsHash']
    return pinata_url


def base64_to_image(base64_string, output_path=None):
    """
    Convert a base64 encoded string to an image file.
    
    Parameters:
    base64_string (str): Base64 encoded image string
    output_path (str, optional): Path to save the image file. 
                                 If None, returns a PIL Image object.
    
    Returns:
    PIL.Image.Image or None: Image object if no output path is provided, 
                              otherwise saves the image to the specified path
    """
    # Remove the data URL prefix if present (e.g., "data:image/png;base64,")
    if ',' in base64_string:
        base64_string = base64_string.split(',')[1]
    
    try:
        # Decode the base64 string
        image_data = base64.b64decode(base64_string)
        
        # Create an image from the decoded data
        image = Image.open(io.BytesIO(image_data))
        
        # If an output path is provided, save the image
        if output_path:
            image.save(output_path)
            print(f"Image saved to {output_path}")
            return None
        
        return image
    
    except Exception as e:
        print(f"Error converting base64 to image: {e}")
        return None

