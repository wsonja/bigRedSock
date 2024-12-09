import base64
import io
from PIL import Image
from openai import OpenAI
import os

def analyze_base64_image(base64_string):
    """
    Convert a base64 string to an image and analyze it using OpenAI's Vision API.
    
    Args:
        base64_string (str): The base64 encoded image string
        api_key (str): Your OpenAI API key
        
    Returns:
        str: Description of what's in the image
    """
    api_key = ""

    try:
        if ',' in base64_string:
            base64_string = base64_string.split(',')[1]
            
        image_bytes = base64.b64decode(base64_string)
        
        image = Image.open(io.BytesIO(image_bytes))
        
        temp_path = "temp_image.png"
        image.save(temp_path)
        
        client = OpenAI(api_key=api_key)
        
        with open(temp_path, "rb") as image_file:
            response = client.chat.completions.create(
                model="gpt-4o",
                messages=[
                    {
                        "role": "user",
                        "content": [
                            {"type": "text", "text": "Give me a concise description under 10 words of what is in this image. Avoid unecessary adjectives. Focus on only one object in the image, do not describe multiple objects."},
                            {
                                "type": "image_url",
                                "image_url": {
                                    "url": f"data:image/png;base64,{base64.b64encode(image_file.read()).decode('utf-8')}"
                                }
                            }
                        ]
                    }
                ],
                max_tokens=300
            )
            
        os.remove(temp_path)
        

        return response.choices[0].message.content
        
    except Exception as e:
        return f"Error analyzing image: {str(e)}"
