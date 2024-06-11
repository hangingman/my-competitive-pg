class ProblemStatement:
    def __init__(self, text: str):
        self.text = text
        self.url = None

    def set_url(self, url: str):
        self.url = url
